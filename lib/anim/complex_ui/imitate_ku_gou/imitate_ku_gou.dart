import 'package:flutter/material.dart';
import 'package:wtoolset/anim/complex_ui/imitate_ku_gou/bottom_view.dart';
import 'package:wtoolset/anim/complex_ui/imitate_ku_gou/top_view.dart';

/// 模仿酷狗
class ImitateKuGou extends StatefulWidget {
  const ImitateKuGou({Key? key}) : super(key: key);

  @override
  State<ImitateKuGou> createState() => _ImitateKuGouState();
}

class _ImitateKuGouState extends State<ImitateKuGou>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double maxSlide = 200;

  bool _canBeDragged = false;

  int direction = -1;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    Future.delayed(Duration.zero, () {
      maxSlide = MediaQuery.of(context).size.width / 1.4;
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

  /// 处理左边按钮
  void handleLeftToggle() {
    if (_animationController.isDismissed) {
      direction = -1;
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  /// 处理右边按钮
  void handleRightToggle() {
    if (_animationController.isDismissed) {
      direction = 1;
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
          MediaQuery.of(context).size.width;

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
        onTap: toggle,
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              double width = MediaQuery.of(context).size.width;

              double paddingRight = width - width / 1.2;

              /// 缩小之后的宽度
              double scaleWidth = width * 0.8;

              /// 缩小之后的两边边距
              double paddingScale = width - scaleWidth;

              /// 缩小之后的两边边距平均值
              double avgPaddingScale = paddingScale / 2;

              double scale = 1 - (_animationController.value * 0.2);

              double topViewSlide = (direction * avgPaddingScale +
                      -1 * direction * (width - paddingRight)) *
                  _animationController.value;

              double bottomViewSlide =
                  direction * paddingRight / 2 * _animationController.value;

              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Transform(
                          transform: Matrix4.identity()
                            ..translate(bottomViewSlide)
                            ..scale(Tween(begin: 0.7, end: 1.0)
                                .evaluate(_animationController)),
                          alignment: Alignment.center,
                          child: const BottomView(),
                        ),
                      ],
                    ),
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(topViewSlide)
                      ..scale(scale),
                    alignment: Alignment.center,
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
                          onLeft: handleLeftToggle,
                          onRight: handleRightToggle,
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
