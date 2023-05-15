import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/common/coordinate.dart';

import 'dart:ui' as ui;

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  _PaperState();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_animationController),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();

  final Animation<double> repaint;

  final List<Offset> points = [];

  Path path = Path();

  final double step = 6;
  final double min = -240;
  final double max = 240;

  PaperPainter(this.repaint) : super(repaint: repaint) {
    initPointsWithPolar();
  }

  void initPointsWithPolar() {
    for (double x = min; x < max; x += step) {
      double thta = (pi / 180 * x); //角度转化为弧度
      var p = f(thta);
      points.add(Offset(p * cos(thta), p * sin(thta)));
    }
    double thta = (pi / 180 * max);
    points.add(Offset(f(thta) * cos(thta), f(thta) * sin(thta)));
    points.add(Offset(f(thta) * cos(thta), f(thta) * sin(thta)));
  }

  // double f(double thta) {
  //   double p =
  //       50 * (pow(e, cos(thta)) - 2 * cos(4 * thta) + pow(sin(thta / 12), 5));
  //   return p;
  // }

  double f(double thta) {
    double p = 150 * sin(5 * thta).abs();
    return p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    var color = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];

    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    paint.shader = ui.Gradient.linear(
      Offset(0, 0),
      Offset(100, 0),
      color,
      pos,
      TileMode.mirror,
    );

    Offset p1 = points[0];

    // Path path = Path()..moveTo(p1.dx, p1.dy);
    path.reset();
    path..moveTo(p1.dx, p1.dy);

    for (var i = 1; i < points.length - 1; i++) {
      double xc = (points[i].dx + points[i + 1].dx) / 2;
      double yc = (points[i].dy + points[i + 1].dy) / 2;
      Offset p2 = points[i];
      path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    }

    // canvas.drawPath(path, paint);

    PathMetrics pms = path.computeMetrics();
    pms.forEach((element) {
      Tangent? tangent =
          element.getTangentForOffset(element.length * repaint.value);

      canvas.drawPath(
          element.extractPath(0, element.length * repaint.value), paint);
      canvas.drawCircle(tangent!.position, 5, Paint()..color = Colors.blue);
    });
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
