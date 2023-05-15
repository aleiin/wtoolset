import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/common/coordinate.dart';

class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final coordinate = Coordinate();
  late Paint _paint; //基础画笔
  late Paint _gridPint; //宫格画笔
  final double step = 20; //小格边长
  final double strokeWidth = .5; //线宽
  final Color color = Colors.grey; //线颜色
  /// 构造函数
  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;

    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // _drawGrid(canvas, size); //画表格
    // _drawAxis(canvas, size); // 画轴

    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2); //将屏幕移到屏幕中心点

    // _drawPoint(canvas, size);

    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    // _drawPart(canvas, paint);
    // _drawDot(canvas, paint);
    // _drawPointsWithPoints(canvas);
    // _drawRawPoints(canvas);
    // _drawRect(canvas);
    // _drawRRect(canvas);
    // _drawDRRect(canvas);
    // _drawFill(canvas);
    _drawPath(canvas);
  }

  void _drawPart(Canvas canvas, Paint paint) {
    // /// 初始化画笔
    // Paint paint = Paint();
    //
    // /// 初始化路径
    // Path path = Path();
    //
    // paint
    //   ..style = PaintingStyle.fill
    //   ..color = Colors.blue;

    // /// 画布起点移到屏幕中心
    // canvas.translate(size.width / 2, size.height / 2);

    /// 画圆
    canvas.drawCircle(Offset(0, 0), 50, paint);

    /// 画线
    canvas.drawLine(
      Offset(20, 20),
      Offset(50, 50),
      paint
        ..color = Colors.red
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawDot(Canvas canvas, Paint paint) {
    final int count = 12;
    paint
      ..color = Colors.orange
      ..style = PaintingStyle.stroke;
    canvas.save();
    for (int i = 0; i < count; i++) {
      var step = 2 * pi / count;
      canvas.drawLine(Offset(80, 0), Offset(100, 0), paint);
      canvas.rotate(step);
    }
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawBottomRight(canvas, size);

    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, step);
    }

    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset.zero, Offset(0, size.height / 2), _gridPint);
      canvas.translate(step, 0);
    }

    canvas.restore();
  }

  /// 画轴
  void _drawAxis(Canvas canvas, Size size) {
    _paint
      ..strokeWidth = 1.5
      ..color = Colors.blue;

    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _paint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _paint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _paint);
  }

  /// 画点
  void _drawPointsWithPoints(Canvas canvas) {
    final List<Offset> points = [
      Offset(-120, -20),
      Offset(-80, -80),
      Offset(-40, -40),
      Offset(0, -100),
      Offset(40, -140),
      Offset(80, -160),
      Offset(120, -100),
    ];

    _paint
      ..color = Colors.red
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(PointMode.polygon, points, _paint);
  }

  /// 绘点集
  void _drawRawPoints(Canvas canvas) {
    Float32List pos = Float32List.fromList([
      -120,
      -20,
      -80,
      -80,
      -40,
      -40,
      0,
      -100,
      40,
      -140,
      80,
      -160,
      120,
      -100,
    ]);
    _paint
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawRawPoints(PointMode.polygon, pos, _paint);
  }

  /// 绘制矩形
  void _drawRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill;

    // [1] 矩形中心构造
    Rect rectFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectFromCenter, _paint);

    // [2].矩形左上右下构造
    Rect rectFromLTRB = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, _paint..color = Colors.red);

    // [3].矩形内切圆构造
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, _paint..color = Colors.orange);

    // [4].矩形内切圆构造
    Rect rectFromCircle = Rect.fromCircle(center: Offset(100, 100), radius: 20);
    canvas.drawRect(rectFromCircle, _paint..color = Colors.green);

    // [5].矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRect(rectFromPoints, _paint..color = Colors.purple);
  }

  /// 绘制圆角矩形
  void _drawRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    // [1].圆角矩形fromRectXY构造
    Rect rectFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRRect(RRect.fromRectXY(rectFromCenter, 40, 20), _paint);

    // [2].圆角矩形fromLTRBXY构造
    canvas.drawRRect(RRect.fromLTRBXY(-120, -120, -80, -80, 10, 10),
        _paint..color = Colors.red);

    // [3].圆角矩形fromLTRBR构造
    canvas.drawRRect(
      RRect.fromLTRBR(80, -120, 120, -80, Radius.circular(10)),
      _paint..color = Colors.orange,
    );

    // [4].圆角矩形fromLTRBAndCorners构造
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        80,
        80,
        120,
        120,
        bottomRight: Radius.elliptical(10, 10),
        topLeft: Radius.elliptical(10, 10),
      ),
      _paint..color = Colors.green,
    );

    // [5].矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 120), Offset(-80, 80));
    canvas.drawRRect(
        RRect.fromRectAndCorners(rectFromPoints,
            bottomRight: Radius.elliptical(10, 10)),
        _paint..color = Colors.purple);
  }

  /// 绘制两个圆角矩形的差域
  void _drawDRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    Rect outRect =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    Rect inRect =
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);

    canvas.drawDRRect(RRect.fromRectXY(outRect, 20, 20),
        RRect.fromRectXY(inRect, 20, 20), _paint);

    Rect outRect2 =
        Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60);
    Rect inRect2 = Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);
    canvas.drawDRRect(
      RRect.fromRectXY(outRect2, 10, 10),
      RRect.fromRectXY(inRect2, 10, 10),
      _paint..color = Colors.green,
    );
  }

  void _drawFill(Canvas canvas) {
    _paint..style = PaintingStyle.stroke;
    canvas.save();
    canvas.translate(-200, 0);
    canvas.drawCircle(Offset(0, 0), 60, _paint);
    canvas.restore();

    var rect = Rect.fromCenter(center: Offset(0, 0), width: 120, height: 100);
    canvas.drawOval(rect, _paint);

    canvas.save();
    canvas.translate(200, 0);
    // drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    canvas.drawArc(rect, 0, pi / 2 * 3, true, _paint);
    canvas.restore();
  }

  void _drawPoint(Canvas canvas, Size size) {
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    _paint
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, 0),
        colors,
        pos,
        ui.TileMode.clamp,
      );
    _paint.blendMode = BlendMode.lighten;
    canvas.drawPaint(_paint);
  }

  /// 绘画路径
  void _drawPath(Canvas canvas) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -60);
    path.close();
    canvas.drawPath(path, _paint..color = Colors.blue);
    canvas.translate(140, 0);
    canvas.drawPath(
      path,
      _paint
        ..style = PaintingStyle.stroke
        ..color = Colors.blue
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
