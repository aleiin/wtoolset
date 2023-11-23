
import 'package:flutter/material.dart';
import 'package:wtoolset/anim/complex_ui/left_right_drawers/bottom_view.dart';
import 'package:wtoolset/anim/complex_ui/left_right_drawers/top_view.dart';

/// 左右抽屉效果
class LeftRightDrawers extends StatefulWidget {
  const LeftRightDrawers({Key? key}) : super(key: key);

  @override
  State<LeftRightDrawers> createState() => _LeftRightDrawersState();
}

class _LeftRightDrawersState extends State<LeftRightDrawers>
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
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
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
    var myChild = Container(
      color: Colors.yellow,
    );

    return Scaffold(
      backgroundColor: const Color(0xffe1e1ff),
      body: GestureDetector(
        onHorizontalDragStart: onHorizontalDragStart,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragEnd: onHorizontalDragEnd,
        // onTap: toggle,
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              double slide = maxSlide * _animationController.value;
              double scale = 1 - (_animationController.value * 0.3);

              return Stack(
                // alignment: AlignmentDirectional.center,
                children: [
                  const BottomView(),
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(-2, 0),
                            blurRadius: 20,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TopView(
                          onLeading: () {
                            toggle();
                          },
                        ),
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
