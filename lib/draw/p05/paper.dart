import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtoolset/draw/common/coordinate.dart';

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
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          OutlinedButton(
            child: Text('开始'),
            onPressed: () {
              if (_animationController.isCompleted) {
                _animationController.reverse(from: 0);
              } else if (_animationController.isDismissed) {
                _animationController.forward();
              }
            },
          ),
          Expanded(
            child: CustomPaint(
              foregroundPainter: PaperPaint(progress: _animationController),
              // painter: PaperPaint(progress: _animationController),
              // child: Text("weibin"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PaperPaint extends CustomPainter {
  final Animation<double> progress;

  final Coordinate coordinate = Coordinate();
  final Paint _paint = Paint();

  PaperPaint({required this.progress}) : super(repaint: progress) {
    _paint
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    // _drawMoveAndLine(canvas);
    // _drawRelativeMoveAndLine(canvas);
    // _drawArcTo(canvas);
    // _drawArcToPointAndRelativeArcToPoint(canvas);
    // _drawConicToAndRelativeConicTo(canvas);
    // _drawQuadraticBezierTo(canvas);
    // _drawAddRectAndRRect(canvas);
    // _drawPolygon(canvas);
    // _drawLine(canvas, size);
    // _drawPathToCloseAndResetAndShift(canvas, size);
    // _drawPathToContainsAndGetBounds(canvas, size);
    // _drawPathToCombine(canvas);
    // _drawPathToComputeMetrics(canvas);
    // _drawAir(canvas, Offset(100, 50));
    _drawLineAndAir(canvas);

    // Offset p0 = Offset.zero;

    // drawItem(canvas, p0, Colors.orange);
  }

  void drawItem(Canvas canvas, Offset center, Color color, double an) {
    Rect rect = Rect.fromCenter(
      center: center,
      width: 20,
      height: 20,
    );
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(1 - an + 0.55);
    canvas.translate(-center.dx, -center.dy);
    // canvas.drawRRect(
    //   RRect.fromRectAndRadius(rect, const Radius.circular(5)),
    //   _paint..color = color,
    // );
    canvas.drawPath(_drawAirPath(canvas, center, 0), _paint);
    canvas.restore();
  }

  /// 画线
  void _drawMoveAndLine(Canvas canvas) {
    Path path = Path();
    _paint
      ..color = Colors.deepOrangeAccent
      ..style = PaintingStyle.fill;

    path
      ..moveTo(0, 0) // 移动到(0,0)点
      ..lineTo(60, 80) // 从(0,0)画线到(60,80)点
      ..lineTo(60, 0) // 从(60,80)画线到(60,0)点
      ..lineTo(0, -80) // 从(60,0)画线到(0,-80)点
      ..close();

    canvas.drawPath(path, _paint);

    _paint
      // ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path
      ..moveTo(0, 0)
      ..lineTo(-60, 80)
      ..lineTo(-60, 0)
      ..lineTo(0, -80)
      ..close();
    canvas.drawPath(path, _paint);
  }

  /// 相对画线
  void _drawRelativeMoveAndLine(Canvas canvas) {
    Path path = Path();

    _paint
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(120, 120)
      ..relativeLineTo(-20, -60)
      ..relativeLineTo(60, -20)
      ..close();

    canvas.drawPath(path, _paint);

    path.reset();
    _paint
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 2;

    path
      ..relativeMoveTo(-200, 0)
      ..relativeLineTo(120, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(60, -10)
      ..close();
    canvas.drawPath(path, _paint);
  }

  /// 画圆弧
  void _drawArcTo(Canvas canvas) {
    Path path = Path();
    _paint
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var rect = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 100);
    path.lineTo(30, 30);
    path..arcTo(rect, 0, pi * 1.5, true);

    canvas.drawPath(path, _paint);

    path.reset();

    canvas.translate(200, 0);
    path.lineTo(30, 30);
    path..arcTo(rect, 0, pi * 1.5, false);

    canvas.drawPath(path, _paint);
  }

  /// 画定弧
  void _drawArcToPointAndRelativeArcToPoint(Canvas canvas) {
    Path path = Path();
    _paint
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path..lineTo(80, -40);

    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: false,
      )
      ..close();

    canvas.drawPath(path, _paint);

    path.reset();
    canvas.translate(-160, 0);
    path..lineTo(80, -40);
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: true,
        clockwise: false,
      )
      ..close();

    canvas.drawPath(path, _paint);

    path.reset();
    canvas.translate(320, 0);
    path..lineTo(80, -40);
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: true,
        clockwise: true,
      )
      ..close();

    canvas.drawPath(path, _paint);
  }

  /// 画圆锥曲线
  void _drawConicToAndRelativeConicTo(Canvas canvas) {
    final Offset p1 = Offset(80, -100);
    final Offset p2 = Offset(160, 0);

    Path path = Path();
    _paint
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    /// 抛物线
    path..conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1);
    canvas.drawPoints(
      PointMode.points,
      [p1, p2],
      _paint,
    );
    canvas.drawPath(path, _paint);

    path.reset();
    canvas.translate(-180, 0);

    /// 椭圆线
    path..conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 0.5);
    canvas.drawPath(path, _paint);

    path.reset();
    canvas.translate(360, 0);

    /// 双曲线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1.5);
    canvas.drawPath(path, _paint);
  }

  /// 画二阶赛尔
  void _drawQuadraticBezierTo(Canvas canvas) {
    final Offset p1 = Offset(100, -100);
    final Offset p2 = Offset(160, 50);

    Path path = Path();

    canvas.drawPoints(
      PointMode.polygon,
      [
        Offset.zero,
        p1,
        p2,
        p1.translate(160, 50),
        p2.translate(160, 50),
      ],
      _paint..strokeCap,
    );
    path..quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.relativeQuadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, _paint);
  }

  /// 给路径添加类矩形
  void _drawAddRectAndRRect(Canvas canvas) {
    Path path = Path();
    path
      ..lineTo(100, 100)
      ..addRect(Rect.fromPoints(Offset(100, 100), Offset(160, 160)))
      ..relativeLineTo(100, -100)
      ..addRRect(
        RRect.fromRectXY(
          Rect.fromPoints(Offset(100, 100), Offset(160, 160))
              .translate(100, -100),
          10,
          10,
        ),
      )
      ..close();
    canvas.drawPath(path, _paint);
  }

  void _drawPolygon(Canvas canvas) {
    Path path = Path();

    var p0 = Offset(100, 100);
    path
      ..lineTo(100, 100)
      ..addPolygon([
        p0,
        p0.translate(20, -20),
        p0.translate(40, -20),
        p0.translate(60, 0),
        p0.translate(60, 20),
        p0.translate(40, 40),
        p0.translate(20, 40),
        p0.translate(0, 20),
      ], true)
      ..addPath(
        Path()..relativeQuadraticBezierTo(125, -100, 260, 0),
        Offset.zero,
      )
      ..lineTo(160, 100);
    canvas.drawPath(path, _paint);
  }

  /// 绘制线段
  void _drawLine(Canvas canvas, Size size) {
    Path path = Path();

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    path
      ..moveTo(0, -size.height / 2)
      ..relativeLineTo(0, size.height)
      ..moveTo(20, -size.height / 2)
      ..relativeLineTo(0, size.height);

    path
      ..moveTo(-size.width / 2, 0)
      ..relativeLineTo(size.width, 0)
      ..moveTo(-size.width / 2, 20)
      ..relativeLineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  /// 绘制路径基本属性 close, reset, shift
  void _drawPathToCloseAndResetAndShift(Canvas canvas, Size size) {
    Path path = Path();

    path
      ..lineTo(100, 100)
      ..relativeLineTo(0, -40)
      ..close(); // 闭合路径

    canvas.drawPath(path, _paint);
    canvas.drawPath(
        path.shift(Offset(120, 0)), _paint); //指定点Offset将路径进行平移,且返回一条新的路径
    canvas.drawPath(path.shift(Offset(240, 0)), _paint);
  }

  /// 判断点是否在路径之内和得到当前路径所在的矩形区域
  void _drawPathToContainsAndGetBounds(Canvas canvas, Size size) {
    Path path = Path();

    _paint..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-40, 120)
      ..relativeLineTo(40, -40)
      ..relativeLineTo(40, 40)
      ..close();

    canvas.drawPath(path, _paint);

    print('print 15:09: ${path.contains(Offset(20, 20))}');
    print('print 15:09: ${path.contains(Offset(0, 20))}');

    Rect bounds = path.getBounds();

    print('print 15:13: ${bounds}');

    // canvas.drawRect(
    //   bounds,
    //   _paint
    //     ..style = PaintingStyle.stroke
    //     ..color = Colors.orange,
    // );

    for (int i = 0; i < 8; i++) {
      canvas
        ..drawPath(
            path.transform(Matrix4.rotationZ(i * pi / 4).storage), _paint);
    }
  }

  /// 路径结合
  void _drawPathToCombine(Canvas canvas) {
    Path path = Path();
    _paint..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-40, 120)
      ..relativeLineTo(40, -40)
      ..relativeLineTo(40, 40)
      ..close();

    var pathOval = Path()
      ..addOval(Rect.fromCenter(center: Offset.zero, width: 60, height: 60));

    canvas.drawPath(
        Path.combine(PathOperation.difference, path, pathOval), _paint);

    canvas.translate(120, 0);
    canvas.drawPath(
        Path.combine(PathOperation.intersect, path, pathOval), _paint);

    canvas.translate(120, 0);
    canvas.drawPath(Path.combine(PathOperation.union, path, pathOval), _paint);

    canvas.translate(-120 * 3.0, 0);
    canvas.drawPath(
        Path.combine(PathOperation.reverseDifference, path, pathOval), _paint);

    canvas.translate(-120, 0);
    canvas.drawPath(Path.combine(PathOperation.xor, path, pathOval), _paint);
  }

  /// 路径测量
  void _drawPathToComputeMetrics(Canvas canvas) {
    Path path = Path();
    Path _pathAir = Path();

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-40, 160)
      ..relativeLineTo(40, -40)
      ..relativeLineTo(40, 40)
      ..close();

    _pathAir
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-40, 160)
      ..relativeLineTo(40, -40)
      ..relativeLineTo(40, 40)
      ..close();

    path.addOval(Rect.fromCenter(center: Offset(0, 0), width: 80, height: 80));
    PathMetrics pathMetrics = path.computeMetrics();

    pathMetrics.forEach(
      (element) {
        Tangent? tangent =
            element.getTangentForOffset(element.length * progress.value);
        print(
            "---position:-${tangent!.position}----angle:-${tangent.angle}----vector:-${tangent.vector}----");

        print(
            "---length:-${element.length}----contourIndex:-${element.contourIndex}----contourIndex:-${element.isClosed}----");

        canvas.drawCircle(
          tangent.position,
          5,
          Paint()..color = Colors.deepOrangeAccent,
        );
      },
    );

    canvas.drawPath(path, _paint);
  }

  /// 画飞机
  void _drawAir(Canvas canvas, Offset offset) {
    Path _pathAir = Path();

    double x = offset.dx;
    double y = offset.dy - 30;

    double a10 = 5;

    double a20 = a10 * 2;

    double a40 = a10 * 4;

    _pathAir
      ..relativeMoveTo(x, y)
      ..relativeLineTo(-a20, a40)
      ..relativeLineTo(-a40, a20)
      ..relativeLineTo(0, a20)
      ..relativeLineTo(a40, -a20)
      ..relativeLineTo(0, a40)
      ..relativeLineTo(-a20, a10)
      ..relativeLineTo(0, a20)
      ..relativeLineTo(a40, -a20)
      ..relativeLineTo(a40, a20)
      ..relativeLineTo(0, -a20)
      ..relativeLineTo(-a20, -a10)
      ..relativeLineTo(0, -a40)
      ..relativeLineTo(a40, a20)
      ..relativeLineTo(0, -a20)
      ..relativeLineTo(-a40, -a20)
      ..close();

    canvas.drawPath(_pathAir, _paint);
  }

  /// 画飞机
  Path _drawAirPath(Canvas canvas, Offset offset, double angle) {
    Path _pathAir = Path();

    double x = offset.dx;
    double y = offset.dy - 30;

    double a10 = 5;

    double a20 = a10 * 2;

    double a40 = a10 * 4;

    _pathAir
      ..relativeMoveTo(x, y)
      ..relativeLineTo(-a20, a40)
      ..relativeLineTo(-a40, a20)
      ..relativeLineTo(0, a20)
      ..relativeLineTo(a40, -a20)
      ..relativeLineTo(0, a40)
      ..relativeLineTo(-a20, a10)
      ..relativeLineTo(0, a20)
      ..relativeLineTo(a40, -a20)
      ..relativeLineTo(a40, a20)
      ..relativeLineTo(0, -a20)
      ..relativeLineTo(-a20, -a10)
      ..relativeLineTo(0, -a40)
      ..relativeLineTo(a40, a20)
      ..relativeLineTo(0, -a20)
      ..relativeLineTo(-a40, -a20)
      ..close();

    // return _pathAir.transform(Matrix4.rotationZ(angle).storage);
    return _pathAir;
  }

  /// 画线和飞机
  void _drawLineAndAir(Canvas canvas) {
    Path path = Path();

    // Offset p1 = Offset(120, -120);
    // Offset p2 = Offset(220, 80);

    Offset p0 = Offset(50, 50);

    // 控制点

    Offset p1 = Offset(100, 300);

    //结束点

    Offset p2 = Offset(300, 300);

    path.moveTo(p0.dx, p0.dy);

    path..quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    PathMetrics pms = path.computeMetrics();

    pms.forEach((pm) {
      Tangent? tangent = pm.getTangentForOffset(pm.length * progress.value);

      double angle = -tangent!.angle / pi * 180;

      drawItem(canvas, tangent.position, Colors.orange, tangent!.angle);

      print('tangent!.angle:${tangent.angle} -- angle: ${angle}');

      // canvas.drawPath(_drawAirPath(canvas, tangent.position, angle), _paint);
    });

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(PaperPaint oldDelegate) =>
      oldDelegate.progress != progress;
}
