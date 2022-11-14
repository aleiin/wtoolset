import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("画圆"),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            padding: EdgeInsets.all(20),
            color: Colors.blueAccent.withAlpha(33),
            child: CustomPaint(
              painter: PaperPainter(repaint: _animationController),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

const double _kPiePadding = 20;

class PaperPainter extends CustomPainter {
  final List<double> yData = [0.12, 0.25, 0.1, 0.18, 0.15, 0.2];
  final List<String> xData = ["学习资料", "伙食费", "话费", "游玩", "游戏", "其他"];
  final List<Color> colors = [
    Colors.red,
    Colors.orangeAccent,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink
  ];

  Animation<double> repaint;

  late double radius;

  Paint linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.red;

  Paint fillPaint = Paint();

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  PaperPainter({required this.repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    radius = size.shortestSide / 2 - _kPiePadding;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black.withAlpha(22),
    );
    canvas.translate(size.width / 2, size.height / 2);
    // canvas.drawCircle(Offset.zero, radius, linePaint);
    // canvas.drawCircle(Offset.zero, 1, Paint());
    canvas.rotate(-pi / 2);
    // canvas.drawLine(Offset.zero, Offset(radius, 0), Paint());

    for (int i = 0; i < yData.length; i++) {
      Color color = colors[i % colors.length];
      Path path = Path();
      path.lineTo(radius, 0);
      path.arcTo(
        Rect.fromCenter(
          center: Offset.zero,
          width: radius * 2,
          height: radius * 2,
        ),
        0,
        2 * pi * yData[i],
        false,
      );
      path.close();
      canvas.drawPath(
        path,
        fillPaint
          ..style = PaintingStyle.fill
          ..color = color,
      );
      canvas.rotate(2 * pi * yData[i]);
    }

    _drawInfo(canvas);
  }

  /// 绘制信息
  void _drawInfo(Canvas canvas) {
    canvas.save();
    for (int i = 0; i < yData.length; i++) {
      Color color = colors[i % colors.length];
      canvas.save();
      canvas.rotate(2 * pi * yData[i] / 2);
      _drawText(
        canvas,
        "${(yData[i] * 100).toStringAsFixed(1)}%",
        color: Colors.white,
        alignment: Alignment.center,
        offset: Offset(radius / 2 + 5, 0),
      );
      Path showPath = Path();
      showPath.moveTo(radius, 0);
      showPath.relativeLineTo(15, 0);
      showPath.relativeLineTo(5, 10);
      canvas.drawPath(
        showPath,
        linePaint
          ..color = color
          ..strokeWidth = 2,
      );

      _drawText(canvas, xData[i],
          color: color,
          alignment: Alignment.centerLeft,
          offset: Offset(radius + 5, 18));

      canvas.restore();

      canvas.rotate(2 * pi * yData[i]);
    }

    canvas.restore();
  }

  /// 绘制文字
  void _drawText(
    Canvas canvas,
    String str, {
    Color color = Colors.blue,
    Alignment alignment = Alignment.centerRight,
    Offset offset = Offset.zero,
  }) {
    TextSpan textSpan = TextSpan(
      text: str,
      style: TextStyle(
        fontSize: 11,
        color: color,
      ),
    );

    _textPainter.text = textSpan;
    _textPainter.layout();

    Size size = _textPainter.size;

    Offset offsetPos = Offset(-size.width / 2, -size.height / 2).translate(
      -size.width / 2 * alignment.x + offset.dx,
      offset.dy,
    );

    _textPainter.paint(canvas, offsetPos);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
