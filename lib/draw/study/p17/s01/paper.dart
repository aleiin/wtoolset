import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/common/coordinate.dart';
import 'package:wtoolset/draw/study/p17/s01/player.dart';

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
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("画码表"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                padding: const EdgeInsets.all(20),
                color: Colors.blueAccent.withAlpha(33),
                child: CustomPaint(
                  painter: PaperPainter(repaint: _animationController),
                ),
              ),
            ),
            Player(
              size: const Size(15, 15),
              callback: (isPlay) {
                print('print 00:16: $isPlay');
              },
            ),
          ],
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

const double _kPiePadding = 20; // 圆边距
const double _kStrokeWidth = 12; // 圆弧宽
const double _kAngle = 270; // 圆弧角度
const int _kMax = 220; // 最大刻度值
const int _kMin = 0; // 最小刻度值
const double _kColorStopRate = 0.2; // 颜色变化分率
const double _kScaleHeightLever1 = 14; // 短刻度线
const double _kScaleHeightLever2 = 18; // 逢5线
const double _kScaleHeightLever3 = 20; // 逢10线
const double _kScaleDensity = 0.5; // 密度
const double _kScaleTextStep = 10; // 刻度文字步长

const List<Color> _kColors = [
  // 颜色列表
  Colors.green,
  Colors.blue,
  Colors.red,
];

class PaperPainter extends CustomPainter {
  Animation<double> repaint;

  Coordinate coordinate = Coordinate();

  /// 位置控制器
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  /// 指针数
  double value = 150;

  /// 圆半径
  double radius = 0;

  /// 填充画笔
  Paint fillPaint = Paint();

  /// 线型画笔
  Paint stokePaint = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  double get initAngle => (360 - _kAngle) / 2;

  PaperPainter({required this.repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(
    //   Offset.zero & size,
    //   Paint()..color = Colors.black.withAlpha(22),
    // );
    coordinate.paint(canvas, size);
    // radius = size.shortestSide / 2 - _kPiePadding;

    radius = 15;

    canvas.translate(size.width / 2, size.height / 2);

    canvas.translate(-radius / 2, 0);

    Path sectorPath = Path()..lineTo(radius, 0);
    Path onePath = Path();
    Path twoPath = Path();

    // _drawText(canvas);
    // _drawArrow(canvas);
    //
    // canvas.rotate(pi / 2);
    //
    // _drawScale(canvas);
    // _drawOutline(canvas);

    canvas.save();
    canvas.rotate(-pi / 4);

    sectorPath.arcTo(
      Rect.fromCenter(
        center: Offset.zero,
        width: radius / 2,
        height: radius / 2,
      ),
      0,
      2 * pi * 0.25,
      false,
    );

    canvas.drawPath(
      sectorPath,
      Paint()..style = PaintingStyle.fill,
    );

    canvas.restore();

    onePath.moveTo(radius, 0);

    onePath.arcTo(
      Rect.fromCenter(
        center: Offset.zero,
        width: radius - (radius / 10) / 2,
        height: radius - (radius / 10) / 2,
      ),
      -pi / 180 * 45,
      pi / 180 * 90,
      true,
    );

    twoPath.moveTo(radius, 0);

    twoPath.arcTo(
      Rect.fromCenter(
        center: Offset.zero,
        width: radius * 1.5 - (radius / 10) / 2,
        height: radius * 1.5 - (radius / 10) / 2,
      ),
      -pi / 180 * 45,
      pi / 180 * 90,
      true,
    );

    Path path = Path()..moveTo(radius, 0);

    path.arcTo(
      Rect.fromCenter(
        center: Offset.zero,
        width: radius - (radius / 10) / 2,
        height: radius - (radius / 10) / 2,
      ),
      -pi / 180 * 45,
      pi / 180 * 90,
      true,
    );

    path.arcTo(
      Rect.fromCenter(
        center: Offset.zero,
        width: radius * 1.5 - (radius / 10) / 2,
        height: radius * 1.5 - (radius / 10) / 2,
      ),
      -pi / 180 * 45,
      pi / 180 * 90,
      true,
    );

    if (repaint.value == 0.0) {
      canvas.drawPath(
        onePath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius / 10,
      );
      canvas.drawPath(
        twoPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius / 10,
      );
    }

    if (repaint.value >= 0.4) {
      canvas.drawPath(
        onePath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius / 10,
      );
    }

    if (repaint.value >= 0.8) {
      canvas.drawPath(
        twoPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius / 10,
      );
    }
  }

  /// 绘制边框
  void _drawOutline(Canvas canvas) {
    Path path = Path()..moveTo(radius, 0);

    path.arcTo(
      Rect.fromCenter(
        center: Offset.zero,
        width: radius * 2,
        height: radius * 2,
      ),
      pi / 180 * initAngle,
      pi / 180 * _kAngle,
      true,
    );

    PathMetrics pathMetrics = path.computeMetrics();

    stokePaint.strokeWidth = _kStrokeWidth;

    for (var element in pathMetrics) {
      canvas.drawPath(
        element.extractPath(0, element.length * _kColorStopRate),
        stokePaint..color = _kColors[0],
      );
      canvas.drawPath(
        element.extractPath(
          element.length * _kColorStopRate,
          element.length * (1 - _kColorStopRate),
        ),
        stokePaint..color = _kColors[1],
      );

      canvas.drawPath(
        element.extractPath(
          element.length * (1 - _kColorStopRate),
          element.length,
        ),
        stokePaint..color = _kColors[2],
      );
    }

    // canvas.drawPath(path, stokePaint);
  }

  /// 绘制刻度
  void _drawScale(Canvas canvas) {
    canvas.save();
    canvas.rotate(pi / 180 * initAngle);
    double len = 0;
    Color color = Colors.red;
    int count = (_kMax * _kScaleDensity).toInt();
    for (int i = _kMin; i <= count; i++) {
      if (i % 5 == 0 && i % 10 != 0) {
        len = _kScaleHeightLever2;
      } else if (i % 10 == 0) {
        len = _kScaleHeightLever3;
      } else {
        len = _kScaleHeightLever1;
      }

      if (i < count * _kColorStopRate) {
        color = Colors.green;
      } else if (i < count * (1 - _kColorStopRate)) {
        color = Colors.blue;
      } else {
        color = Colors.red;
      }
      canvas.drawLine(
        Offset(radius + _kStrokeWidth / 2, 0),
        Offset(radius - len, 0),
        stokePaint
          ..color = color
          ..strokeWidth = 1,
      );
      canvas.rotate(pi / 180 / _kMax * _kAngle / _kScaleDensity);
    }
    canvas.restore();
  }

  /// 绘制指针
  void _drawArrow(Canvas canvas) {
    var nowPer = value / _kMax;
    Color color = Colors.red;
    canvas.save();
    canvas.rotate(pi / 180 * (-_kAngle / 2 + nowPer * _kAngle * repaint.value));
    Path arrowPath = Path();
    arrowPath.moveTo(0, 18);
    arrowPath.relativeLineTo(-6, -10);
    arrowPath.relativeLineTo(6, -radius + 10);
    arrowPath.relativeLineTo(6, radius - 10);
    arrowPath.close();

    if (nowPer < _kColorStopRate) {
      color = _kColors[0];
    } else if (nowPer < (1 - _kColorStopRate)) {
      color = _kColors[1];
    } else {
      color = _kColors[2];
    }

    canvas.drawPath(
      arrowPath,
      fillPaint..color = color,
    );

    canvas.drawCircle(
      Offset.zero,
      3,
      stokePaint
        ..color = Colors.yellow
        ..strokeWidth = 1,
    );

    canvas.drawCircle(
      Offset.zero,
      3,
      fillPaint..color = Colors.white,
    );

    canvas.restore();
  }

  /// 绘制文字
  void _drawText(Canvas canvas) {
    _drawAxisText(
      canvas,
      "km/s",
      fontSize: 20,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      alignment: Alignment.center,
      color: Colors.black,
      offset: Offset(0, -radius / 2),
    );

    _drawAxisText(
      canvas,
      (value * repaint.value).toStringAsFixed(1),
      fontSize: 16,
      alignment: Alignment.center,
      color: Colors.black,
      offset: Offset(0, radius / 2),
    );

    int count = (_kMax - _kMin) * _kScaleDensity ~/ 10;

    // print('print 23:13: ${count}');
    // print('print 23:31: ${initAngle}');
    Color color = Colors.red;
    for (int i = _kMin; i <= count; i++) {
      var thta = pi / 180 * (90 + initAngle + (_kAngle / count) * i);

      print('print 23:48: $thta');
      if (i < count * _kColorStopRate) {
        color = _kColors[0];
      } else if (i < count * (1 - _kColorStopRate)) {
        color = _kColors[1];
      } else {
        color = _kColors[2];
      }
      Rect rect = Rect.fromLTWH(
        (radius - 40) * cos(thta) - 12,
        (radius - 40) * sin(thta) - 8,
        24,
        16,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(3)),
        fillPaint..color = color,
      );
      _drawAxisText(
        canvas,
        "${i * 10 ~/ _kScaleDensity}",
        fontSize: 11,
        alignment: Alignment.center,
        color: Colors.white,
        offset: Offset(
          (radius - 40) * cos(thta),
          (radius - 40) * sin(thta),
        ),
      );

      canvas.drawCircle(
          Offset(
            (radius - 40) * cos(thta),
            (radius - 40) * sin(thta),
          ),
          1,
          Paint());
    }
  }

  void _drawAxisText(
    Canvas canvas,
    String str, {
    Color color = Colors.black,
    double fontSize = 11,
    FontStyle fontStyle = FontStyle.normal,
    Alignment alignment = Alignment.centerRight,
    FontWeight fontWeight = FontWeight.normal,
    Offset offset = Offset.zero,
  }) {
    TextSpan textSpan = TextSpan(
      text: str,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
      ),
    );

    _textPainter.text = textSpan;

    _textPainter.layout();

    Size size = _textPainter.size;

    Offset offsetPos = Offset(
      -size.width / 2,
      -size.height / 2,
    ).translate(
      -size.width / 2 * alignment.x + offset.dx,
      offset.dy,
    );

    _textPainter.paint(canvas, offsetPos);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
