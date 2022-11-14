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
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("char"),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 300,
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

/// 刻度高
const double _kScaleHeight = 8;

///柱状图前间隔
const double _kBarPadding = 10;

class PaperPainter extends CustomPainter {
  final List<double> yData = [88, 98, 70, 80, 100, 75];
  final List<String> xData = ["7月", "8月", "9月", "10月", "11月", "12月"];
  final List<Offset> line = [];

  Animation<double> repaint;

  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  Path path = Path();
  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;
  Paint fillPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  Paint linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..strokeCap = StrokeCap.round;

  /// x 间隔
  double xStep = 0;

  /// y 间隔
  double yStep = 0;

  /// 数据最大值
  double maxData = 0;

  PaperPainter({required this.repaint}) : super(repaint: repaint) {
    maxData = yData.reduce(max);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawAssist(canvas, size);
    canvas.translate(0, size.height);
    canvas.translate(_kScaleHeight, -_kScaleHeight);

    path.moveTo(-_kScaleHeight, 0);
    path.relativeLineTo(size.width, 0);

    path.moveTo(0, _kScaleHeight);
    path.relativeLineTo(0, -size.height);

    canvas.drawPath(path, axisPaint);

    // canvas.drawCircle(
    //   Offset.zero,
    //   10,
    //   Paint()
    //     ..color = Colors.black
    //     ..style = PaintingStyle.stroke,
    // );

    _drawYText(canvas, size);
    _drawXText(canvas, size);
    _drawBarChart(canvas, size);
    collectPoints(canvas, size);
    _drawLineChart(canvas);
  }

  /// 辅助
  void _drawAssist(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black.withAlpha(22),
    );
  }

  ///
  void _drawYText(Canvas canvas, Size size) {
    canvas.save();

    yStep = (size.height - _kScaleHeight) / 5;

    double numStep = maxData / 5;

    for (int i = 0; i <= 5; i++) {
      if (i == 0) {
        _drawAxisText(canvas, "0", offset: Offset(-10, 2));
        canvas.translate(0, -yStep);
        continue;
      }

      canvas.drawLine(
        Offset(0, 0),
        Offset(size.width - _kScaleHeight, 0),
        gridPaint,
      );
      canvas.drawLine(
        Offset(-_kScaleHeight, 0),
        Offset.zero,
        axisPaint,
      );
      String str = '${(numStep * i).toStringAsFixed(0)}';
      _drawAxisText(canvas, str, offset: Offset(-10, 2));
      canvas.translate(0, -yStep);
    }
    canvas.restore();
  }

  ///
  void _drawXText(Canvas canvas, Size size) {
    xStep = (size.width - _kScaleHeight) / xData.length;
    canvas.save();
    canvas.translate(xStep, 0);
    for (int i = 0; i < xData.length; i++) {
      canvas.drawLine(Offset.zero, Offset(0, _kScaleHeight), axisPaint);
      _drawAxisText(
        canvas,
        xData[i],
        alignment: Alignment.center,
        offset: Offset(-xStep / 2, 10),
      );
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  ///
  void _drawBarChart(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(xStep, 0);
    for (int i = 0; i < xData.length; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          _kScaleHeight,
          0,
          xStep - 2 * _kBarPadding,
          -(yData[i] / maxData * (size.height - _kScaleHeight)) * repaint.value,
        ).translate(-xStep, 0),
        fillPaint,
      );
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  /// 文字
  void _drawAxisText(
    Canvas canvas,
    String str, {
    Color color = Colors.black,
    bool x = false,
    Alignment alignment = Alignment.centerRight,
    Offset offset = Offset.zero,
  }) {
    TextSpan textSpan = TextSpan(
        text: str,
        style: TextStyle(
          fontSize: 11,
          color: color,
        ));
    _textPainter.text = textSpan;
    _textPainter.layout();

    Size size = _textPainter.size;

    Offset offsetPos = Offset(-size.width / 2, -size.height / 2)
        .translate(-size.width / 2 * alignment.x + offset.dx, 0 + offset.dy);

    _textPainter.paint(canvas, offsetPos);
  }

  void collectPoints(Canvas canvas, Size size) {
    line.clear();
    canvas.translate(xStep, 0);
    for (int i = 0; i < xData.length; i++) {
      double dataHeight = -(yData[i] / maxData * (size.height - _kScaleHeight));
      line.add(Offset(xStep * i - xStep / 2, dataHeight));
    }
    linePaint..strokeWidth = 1;
  }

  void _drawLineChart(Canvas canvas) {
    canvas.drawPoints(PointMode.points, line, linePaint..strokeWidth = 5);
    Offset p1 = line[0];
    Path path = Path()..moveTo(p1.dx, p1.dy);
    for (int i = 1; i < line.length; i++) {
      path.lineTo(line[i].dx, line[i].dy);
    }
    linePaint..strokeWidth = 1;
    PathMetrics pathMetric = path.computeMetrics();
    pathMetric.forEach((e) {
      canvas.drawPath(e.extractPath(0, e.length * repaint.value), linePaint);
    });
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
