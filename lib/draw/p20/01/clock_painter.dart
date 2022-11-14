import 'package:flutter/material.dart';
import 'package:wtoolset/draw/p20/01/clock_manage.dart';

class ClockPainter extends CustomPainter {
  ClockPainter({this.manage}) : super(repaint: manage);

  final ClockManage? manage;

  Paint clockPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    if (manage != null) {
      manage!.particles?.where((element) => element != null).forEach((element) {
        clockPaint..color = element.color;
        canvas.drawCircle(
            Offset(element.x, element.y), element.size, clockPaint);
      });
    }
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) =>
      oldDelegate.manage != manage;
}
