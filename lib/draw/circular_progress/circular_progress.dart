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

  /// 进度
  double progress = 0.25;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('当前进度: $progress'),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            progress = 0.1;
                          });
                        },
                        child: const Text('1%'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            progress = 0.25;
                          });
                        },
                        child: const Text('25%'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            progress = 0.5;
                          });
                        },
                        child: const Text('50%'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            progress = 0.75;
                          });
                        },
                        child: const Text('75%'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            progress = 0.99;
                          });
                        },
                        child: const Text('99%'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            progress = 1;
                          });
                        },
                        child: const Text('100%'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 182,
                    height: 182,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 182,
                          height: 182,
                          color: Colors.orange,
                          child: CustomPaint(
                            painter: CircularProgressPaint(
                              repaint: animationController,
                              progress: progress,
                              backgroundColor: const Color(0xffDDF4ED),
                              progressColor: const Color(0xff60F1A4),
                              colors: [
                                const Color(0xFF60F1A4),
                                const Color(0xFF4FD3CD),
                              ],
                              stops: [1.0 / 2, 1.0],
                              // strokeCap: StrokeCap.butt,
                            ),
                          ),
                        ),
                        Container(
                          width: sqrt(2) * (182 / 2 - 20),
                          height: sqrt(2) * (182 / 2 - 20),
                          decoration: const BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            // shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: AnimatedBuilder(
                            animation: animationController,
                            builder: (BuildContext context, Widget? child) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('自绘'),
                                  Text(
                                      '${(animationController.value * progress * 10000).toStringAsFixed(0)}/10000'),
                                ],
                              );
                            },
                          ),
                          // child: Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text(
                          //       '完成度',
                          //       maxLines: 1,
                          //       overflow: TextOverflow.ellipsis,
                          //       style: TextStyle(
                          //         fontSize: 14,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //     const SizedBox(height: 7),
                          //     AnimatedBuilder(
                          //       animation: animationController,
                          //       builder: (BuildContext context, Widget? child) {
                          //         String p = '999';
                          //         return RichText(
                          //           text: TextSpan(
                          //             children: <InlineSpan>[
                          //               TextSpan(
                          //                 text: p,
                          //                 // text: (animationController.value)
                          //                 //     .toStringAsFixed(1),
                          //                 style: const TextStyle(
                          //                   fontSize: 24,
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //               TextSpan(
                          //                 text: '/$p',
                          //                 style: const TextStyle(
                          //                   color: Colors.white,
                          //                   fontSize: 12,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           maxLines: 2,
                          //           overflow: TextOverflow.ellipsis,
                          //         );
                          //       },
                          //     ),
                          //   ],
                          // ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 182,
                    height: 182,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 182,
                          height: 182,
                          color: Colors.orange,
                          child: CustomPaint(
                            painter: CircularProgressPaint(
                              repaint: animationController,
                              progress: progress,
                              backgroundColor: const Color(0xffDDF4ED),
                              progressColor: const Color(0xff60F1A4),
                              colors: [
                                const Color(0xFF60F1A4),
                                const Color(0xFF4FD3CD),
                              ],
                              stops: [1.0 / 2, 1.0],
                              // strokeCap: StrokeCap.butt,
                            ),
                          ),
                        ),
                        Container(
                          width: sqrt(2) * (182 / 2 - 20),
                          height: sqrt(2) * (182 / 2 - 20),
                          decoration: const BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            // shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          // child: AnimatedBuilder(
                          //   animation: animationController,
                          //   builder: (BuildContext context, Widget? child) {
                          //     return Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         const Text('自绘'),
                          //         Text(
                          //             '${(animationController.value * progress * 10000).toStringAsFixed(0)}/10000'),
                          //       ],
                          //     );
                          //   },
                          // ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '完成度',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 7),
                              AnimatedBuilder(
                                animation: animationController,
                                builder: (BuildContext context, Widget? child) {
                                  String p = '999';
                                  return RichText(
                                    text: TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: (animationController.value *
                                                  progress *
                                                  1000)
                                              .toStringAsFixed(0),
                                          style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '/1000',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 182,
                    height: 182,
                    color: Colors.orange,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 182,
                          height: 182,
                          child: const CircularProgressIndicator(
                            // value: 179 / 180,
                            value: 90 / 180,
                            strokeWidth: 20,
                            strokeAlign: -1,
                            strokeCap: StrokeCap.round,
                            backgroundColor: Color(0xffDDF4ED),
                            color: Color(0xff60F1A4),
                          ),
                        ),
                        Container(
                          width: sqrt(2) * (182 / 2 - 20),
                          height: sqrt(2) * (182 / 2 - 20),
                          decoration: const BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            // shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text('官方'),
                          // child: Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       '完成度',
                          //       maxLines: 1,
                          //       overflow: TextOverflow.ellipsis,
                          //       style: const TextStyle(
                          //         fontSize: 14,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //     const SizedBox(height: 7),
                          //     AnimatedBuilder(
                          //       animation: animationController,
                          //       builder: (BuildContext context, Widget? child) {
                          //         String p = '999';
                          //         return RichText(
                          //           text: TextSpan(
                          //             children: <InlineSpan>[
                          //               TextSpan(
                          //                 text: p,
                          //                 // text: (animationController.value)
                          //                 //     .toStringAsFixed(1),
                          //                 style: const TextStyle(
                          //                   fontSize: 24,
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //               TextSpan(
                          //                 text: '/$p',
                          //                 style: const TextStyle(
                          //                   color: Colors.white,
                          //                   fontSize: 12,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           maxLines: 2,
                          //           overflow: TextOverflow.ellipsis,
                          //         );
                          //       },
                          //     ),
                          //   ],
                          // ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: MediaQuery.of(context).size.height,
              color: Colors.black87,
            ),
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
    this.strokeCap = StrokeCap.round,
    this.colors,
    this.stops,
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

  ///
  final StrokeCap strokeCap;

  ///
  final List<Color>? colors;

  ///
  final List<double>? stops;

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
      ..strokeCap = strokeCap // 笔触设置为圆角
      ..style = PaintingStyle.stroke; // 画笔风格，线

    /// 半径，这里为防止宽高不一致，取较小值的一半作为半径大小
    double radius = size.width > size.height ? size.height / 2 : size.width / 2;

    /// 圆半径
    double circleRadius = radius - width / 2;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      circleRadius,
      paintBg,
    );

    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: circleRadius,
    );

    /// 需要扫描的弧度
    double sweepAngle = progress * 2 * pi * repaint.value;

    if (strokeCap == StrokeCap.butt) {
      /// 不出头
      canvas.drawArc(
        rect,
        -pi / 2,
        sweepAngle,
        false,
        paintProgress,
      );
    } else {
      /// 开始需要减去的弧度
      double startArc = asin((width / 2) / circleRadius);

      /// 结尾需要减去的弧度
      double endArc = asin(width / circleRadius);

      if (repaint.value == 0.0 || progress == 0.0) {
        sweepAngle = 0;
      } else if (progress == 1.0) {
        sweepAngle = sweepAngle;
      } else if (sweepAngle - endArc < 0) {
        sweepAngle = endArc - startArc * 2;
      } else if (sweepAngle > endArc) {
        sweepAngle = sweepAngle - endArc;
      }

      /// 渐变示例
      /// var colors = [
      ///   Color(0xFF60F1A4),
      ///   Color(0xFF4FD3CD),
      /// ];
      /// var stops = [1.0 / 2, 2.0 / 2];
      if ((colors ?? []).isNotEmpty &&
          (stops ?? []).isNotEmpty &&
          colors!.length == stops!.length) {
        paintProgress.shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors!,
          stops: stops,
          tileMode: TileMode.clamp,
        ).createShader(rect);
      }

      canvas.drawArc(
        rect,
        -pi / 2 + startArc,
        sweepAngle,
        false,
        paintProgress,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CircularProgressPaint oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
