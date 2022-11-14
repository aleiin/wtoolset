import 'dart:math';

import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  Player({
    Key? key,
    required this.size,
    this.isPlays = false,
    this.callback,
  }) : super(key: key);

  final Size size;

  final bool isPlays;

  Function(bool isPlays)? callback;

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  /// 动画器
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    if (widget.isPlays) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(Player oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlays != oldWidget.isPlays) {
      if (widget.isPlays) {
        _animationController.repeat();
      } else {
        _animationController.stop();
        _animationController.reverse(from: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: PaperPainter(repaint: _animationController),
    );
  }
}

class PaperPainter extends CustomPainter {
  Animation<double> repaint;

  /// 圆半径
  double radius = 0;

  PaperPainter({
    required this.repaint,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    radius = size.shortestSide;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(-radius / 2, 0);

    Path sectorPath = Path()..lineTo(radius, 0);
    Path onePath = Path();
    Path twoPath = Path();

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

    onePath..moveTo(radius, 0);

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

    twoPath..moveTo(radius, 0);

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

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
