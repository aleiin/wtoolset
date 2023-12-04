import 'package:flutter/material.dart';
import 'package:wtoolset/draw/painter_badge/painter_badge_paint.dart';

/// 自绘角标
class PainterBadge extends StatelessWidget {
  const PainterBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自绘角标'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 28, top: 16, right: 28),
        // color: Colors.deepPurpleAccent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 319 / 242,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      child: CustomPaint(
                        painter: PainterBadgePaint(
                          isQuadraticBezier: false,
                          text: '通过圆弧绘制',
                          bgColor: Color(0xff77DEA7),
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          shadows: [
                            BoxShadow(
                              // color: Colors.black.withOpacity(0.25),
                              color: Colors.redAccent,
                              offset: Offset(0, 4),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 50,
                      child: CustomPaint(
                        painter: PainterBadgePaint(
                          isQuadraticBezier: true,
                          text: '贝塞尔曲绘制',
                          bgColor: Color(0xff77DEA7),
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          shadows: [
                            BoxShadow(
                              // color: Colors.black.withOpacity(0.25),
                              color: Colors.redAccent,
                              offset: Offset(0, 4),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 319 / 242,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 0,
                      child: CustomPaint(
                        painter: PainterBadgePaint(
                          isQuadraticBezier: false,
                          text: '通过圆弧绘制',
                          bgColor: Color(0xff77DEA7),
                          // alignment: Alignment.centerLeft,
                          alignment: Alignment.centerRight,
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          shadows: [
                            BoxShadow(
                              // color: Colors.black.withOpacity(0.25),
                              color: Colors.redAccent,
                              offset: Offset(0, 4),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 50,
                      right: 0,
                      child: CustomPaint(
                        painter: PainterBadgePaint(
                          isQuadraticBezier: true,
                          text: '贝塞尔曲绘制',
                          bgColor: Color(0xff77DEA7),
                          // alignment: Alignment.centerLeft,
                          alignment: Alignment.centerRight,
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          shadows: [
                            BoxShadow(
                              // color: Colors.black.withOpacity(0.25),
                              color: Colors.redAccent,
                              offset: Offset(0, 4),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 319 / 242,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const Positioned(
                      right: 0,
                      child: CustomPaint(
                        painter: PainterBadgePaint(
                          isQuadraticBezier: false,
                          text: '換罄',
                          bgColor: Color(0xffC4C4C4),
                          // alignment: Alignment.centerLeft,
                          alignment: Alignment.centerRight,
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          shadows: [
                            BoxShadow(
                              // color: Colors.black.withOpacity(0.25),
                              color: Colors.redAccent,
                              offset: Offset(0, 4),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
