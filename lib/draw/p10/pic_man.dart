import 'dart:math';

import 'package:flutter/material.dart';

class PicMan extends StatefulWidget {
  final Color color; // 颜色
  final double angle; // 角度

  const PicMan({Key? key, this.color = Colors.lightBlue, this.angle = 30})
      : super(key: key);

  @override
  _PicManState createState() => _PicManState();
}

class _PicManState extends State<PicMan> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      // lowerBound: 10, // 运动的下限
      // upperBound: 40, // 运动的上限
      vsync: this,
      duration: Duration(seconds: 1), // 运动时长
    );
    // ..repeat(reverse: true);

    _angleAnimation = _animationController.drive(Tween(begin: 10, end: 40));

    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red)
        .animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: PicManPainter(color: _colorAnimation, angle: _angleAnimation),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PicManPainter extends CustomPainter {
  final Animation<Color?> color; // 颜色
  final Animation<double> angle; // 角度(与x轴交角, 角度制)

  Paint _paint = Paint(); // 画笔

  PicManPainter({required this.color, required this.angle})
      : super(repaint: angle); // 传入ListenAble可监听对象

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); // 剪切画布
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);

    _drawHead(canvas, size);
    _drawEye(canvas, radius);
  }

  /// 绘制头
  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(
        center: Offset.zero, width: size.width, height: size.height);
    var a = angle.value / 180 * pi;
    canvas.drawArc(
        rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color.value!);
  }

  /// 绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant PicManPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.angle != angle;
}
