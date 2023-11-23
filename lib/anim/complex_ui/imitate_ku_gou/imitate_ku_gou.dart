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

  /// 是否是左边启动
  bool isLeftStart = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    Future.delayed(Duration.zero, () {
      maxSlide = MediaQuery.of(context).size.width;
    });
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
      isLeftStart = true;
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  /// 处理右边按钮
  void handleRightToggle() {
    if (_animationController.isDismissed) {
      isLeftStart = false;
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  /// dismissed：动画停止在开始处。
  /// forward：动画正在从开始处运行到结束处（正向运行）。
  /// reverse：动画正在从结束处运行到开始处（反向运行）。
  /// completed：动画停止在结束处。
  void onHorizontalDragStart(DragStartDetails details) {
    if (_animationController.isAnimating) {
      return;
    }

    double width = MediaQuery.of(context).size.width;

    double aveWidth = width / 2;

    /// 动画停止在开始处
    bool isDismissed = _animationController.isDismissed;

    if (isDismissed) {
      isLeftStart = _animationController.isDismissed &&
          details.globalPosition.dx < aveWidth;
    }
  }

  ///
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_animationController.isAnimating) {
      return;
    }

    double sign = details.primaryDelta!.sign;

    if (isLeftStart) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    } else {
      double delta = details.primaryDelta! / maxSlide;
      if (sign == 1) {
        _animationController.value -= delta;
      } else if (sign == -1) {
        _animationController.value += delta.abs();
      } else {}
    }
  }

  ///
  void onHorizontalDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      if (isLeftStart) {
        double visualVelocity = details.velocity.pixelsPerSecond.dx /
            MediaQuery.of(context).size.width;

        _animationController.fling(velocity: visualVelocity);
      } else {
        double visualVelocity = details.velocity.pixelsPerSecond.dx /
            -MediaQuery.of(context).size.width;

        _animationController.fling(velocity: visualVelocity);
      }
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

              ///
              double topViewSlide = 0.0;

              ///
              double bottomViewSlide = 0.0;

              if (isLeftStart) {
                /// 左边启动

                topViewSlide = (-avgPaddingScale + (width - paddingRight)) *
                    _animationController.value;

                bottomViewSlide =
                    -paddingRight / 2 * _animationController.value;
              } else {
                /// 右边启动
                topViewSlide = (avgPaddingScale - (width - paddingRight)) *
                    _animationController.value;

                bottomViewSlide = paddingRight / 2 * _animationController.value;
              }

              return Stack(
                children: [
                  SizedBox(
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
