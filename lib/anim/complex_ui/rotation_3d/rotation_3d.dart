import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wtoolset/anim/complex_ui/rotation_3d/bottom_view.dart';
import 'package:wtoolset/anim/complex_ui/rotation_3d/top_view.dart';

/// 3d旋转效果
class Rotation3d extends StatefulWidget {
  const Rotation3d({Key? key}) : super(key: key);

  @override
  State<Rotation3d> createState() => _Rotation3dState();
}

class _Rotation3dState extends State<Rotation3d>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double maxSlide = 200;

  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    Future.delayed(Duration.zero, () {
      maxSlide = MediaQuery.of(context).size.width / 1.2;
    });

    // _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ///
  void toggle() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  ///
  void onHorizontalDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < MediaQuery.of(context).size.width;

    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxSlide;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  ///
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    double delta = details.primaryDelta! / maxSlide;
    _animationController.value += delta;
  }

  ///
  void onHorizontalDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQueryData.fromView(View.of(context)).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe1e1ff),
      body: GestureDetector(
        onHorizontalDragStart: onHorizontalDragStart,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragEnd: onHorizontalDragEnd,
        // onTap: toggle,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Stack(
                children: [
                  Transform.translate(
                    offset:
                        Offset(maxSlide * (_animationController.value - 1), 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(pi / 2 * (1 - _animationController.value)),
                      alignment: Alignment.centerRight,
                      child: const BottomView(),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(maxSlide * _animationController.value, 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-pi / 2 * _animationController.value),
                      alignment: Alignment.centerLeft,
                      child: TopView(
                        onLeading: () {
                          toggle();
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
