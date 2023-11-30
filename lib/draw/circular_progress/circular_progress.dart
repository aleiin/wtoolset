import 'dart:math';

import 'package:flutter/material.dart';

/// 圆形进度条
class CircularProgress extends StatefulWidget {
  const CircularProgress({Key? key}) : super(key: key);

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  ///
  void toggle() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('圆形进度条'),
        actions: [
          TextButton(
            onPressed: toggle,
            child: const Text(
              '测试',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 126,
              height: 126,
              color: Colors.orange,
              child: CustomPaint(
                painter: CircularProgressPaint(
                  repaint: animationController,
                  // progress: 1 / 4,
                  // progress: 0.99,
                  progress: 1 / 14,
                  backgroundColor: const Color(0xffDDF4ED),
                  progressColor: const Color(0xff60F1A4),
                ),
              ),
            ),
            Container(
              width: sqrt(2) * (126 / 2 - 20),
              height: sqrt(2) * (126 / 2 - 20),
              decoration: const BoxDecoration(
                color: Colors.deepPurpleAccent,
                // shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '完成度' * 10,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (BuildContext context, Widget? child) {
                      return RichText(
                        text: const TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: '14',
                              // text: (animationController.value)
                              //     .toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '/14',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Container(
            //   width: 126 / 2 + 20,
            //   height: 126 / 2 + 20,
            //   decoration: const BoxDecoration(
            //     color: Colors.deepPurpleAccent,
            //     // shape: BoxShape.circle,
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         '完成度',
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //         style: TextStyle(
            //           fontSize: 14,
            //           color: Colors.white,
            //         ),
            //       ),
            //       AnimatedBuilder(
            //         animation: animationController,
            //         builder: (BuildContext context, Widget? child) {
            //           return RichText(
            //             text: TextSpan(
            //               children: <InlineSpan>[
            //                 TextSpan(
            //                   text: (animationController.value)
            //                       .toStringAsFixed(1),
            //                   style: TextStyle(
            //                     fontSize: 24,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //                 TextSpan(
            //                   text: '/1.0',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class CircularProgressPaint extends CustomPainter {
  const CircularProgressPaint({
    this.progress = 1,
    this.width = 20,
    this.backgroundColor = Colors.deepPurpleAccent,
    this.progressColor = Colors.red,
    required this.repaint,
  }) : super(repaint: repaint);

  /// 背景画笔颜色
  final Color backgroundColor;

  /// 进度: 0-1
  final double progress;

  /// 进度颜色
  final Color progressColor;

  ///  画笔宽度
  final double width;

  /// 动画
  final Animation<double> repaint;

  @override
  void paint(Canvas canvas, Size size) {
    //背景画笔
    Paint paintBg = Paint()
      ..color = backgroundColor
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..style = PaintingStyle.stroke; // 画笔风格，线

    //进度画笔
    Paint paintProgress = Paint()
      ..color = progressColor
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为圆角
      ..style = PaintingStyle.stroke; // 画笔风格，线

    /// 半径，这里为防止宽高不一致，取较小值的一半作为半径大小
    double radius = size.width > size.height ? size.height / 2 : size.width / 2;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius - width / 2,
      paintBg,
    );

    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius - width / 2,
    );

    canvas.drawArc(
      rect,
      -pi / 2,
      progress * 2 * pi * repaint.value,
      false,
      paintProgress,
    );
  }

  @override
  bool shouldRepaint(covariant CircularProgressPaint oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
