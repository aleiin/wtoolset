import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/common/coordinate.dart';

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
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
  /// 坐标系
  Coordinate coordinate = Coordinate();

  /// 画笔
  Paint _paint = Paint();

  /// 辅助画笔
  Paint _helpPaint = Paint();

  /// 路径
  Path path = Path();

  Offset p1 = Offset(100, 100);
  Offset p2 = Offset(120, -60);

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    _paint
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, _paint);
    _drawHelp(canvas);
  }

  void _drawHelp(Canvas canvas) {
    _helpPaint
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(
      PointMode.lines,
      [Offset.zero, p1, p1, p2],
      _helpPaint..strokeWidth = 1,
    );

    canvas.drawPoints(
      PointMode.points,
      [Offset.zero, p1, p1, p2],
      _helpPaint..strokeWidth = 8,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
