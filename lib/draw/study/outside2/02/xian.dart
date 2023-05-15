import 'package:flutter/material.dart';

class Xian extends CustomPainter {
  final p0;

  final p1;

  final p2;

  Xian({this.p0, this.p1, this.p2});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = .3
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..invertColors = false;

    Path path = Path();

    // 移动到起点

    path.moveTo(p0.dx, p0.dy);

    // 以p1为控制点，画一个到p2的曲线

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    // 绘画

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(Xian oldDelegate) {
    return this != oldDelegate;
  }
}
