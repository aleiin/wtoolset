import 'package:flutter/material.dart';

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
                    const CustomPaint(
                      painter: PainterBadgePaint(
                        text: '限量兌換限量兌換限量兌換限量兌換限量兌換限量兌換',
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
                          text: '限量兌換',
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

class PainterBadgePaint extends CustomPainter {
  const PainterBadgePaint({
    this.bgColor = Colors.blue,
    this.text = '角标',
    this.textStyle,
    this.horizontal = 2,
    this.vertical = 4,
    this.alignment = Alignment.centerLeft,
    this.shadows = const [],
  });

  /// 背景颜色, 好像暂时没用
  final Color bgColor;

  ///
  final String text;

  ///
  final TextStyle? textStyle;

  /// 水平方向padding
  final double horizontal;

  /// 垂直方向padding
  final double vertical;

  ///
  final Alignment alignment;

  /// 阴影
  final List<BoxShadow> shadows;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    Path path = Path();

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle ??
            const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    /// 进行布局
    textPainter.layout();

    /// 尺寸必须在布局后获取
    Size textSize = textPainter.size;

    double textWidth = textSize.width + horizontal * 2;

    double textHeight = textSize.height + vertical * 2;

    double width = textHeight / 2;

    if (alignment == Alignment.centerLeft) {
      path.moveTo(width, 0);
    } else if (alignment == Alignment.centerRight) {
      path.moveTo(0 - textWidth - width, 0);
    }

    path.relativeLineTo(textWidth, 0);

    path.relativeQuadraticBezierTo(width, 0, width, width);

    path.relativeLineTo(0, textHeight);

    path.relativeQuadraticBezierTo(0, -width, -width, -width);

    path.relativeLineTo(-textWidth, 0);

    path.relativeQuadraticBezierTo(-width, 0, -width, -width);

    path.relativeQuadraticBezierTo(0, -width, width, -width);

    path.close();

    /// 绘制阴影
    drawShadows(canvas, path, shadows);

    canvas.drawPath(path, paint);

    if (alignment == Alignment.centerLeft) {
      textPainter.paint(
        canvas,
        Offset(width + horizontal, vertical),
      );
    } else if (alignment == Alignment.centerRight) {
      textPainter.paint(
        canvas,
        Offset(0 - width - textWidth + horizontal, vertical),
      );
    }
  }

  /// 绘制阴影
  /// 参考链接: [https://juejin.cn/post/7194250504518500409]
  void drawShadows(Canvas canvas, Path path, List<BoxShadow> shadows) {
    for (final BoxShadow shadow in shadows) {
      final Paint shadowPainter = shadow.toPaint();
      if (shadow.spreadRadius == 0) {
        canvas.drawPath(path.shift(shadow.offset), shadowPainter);
      } else {
        Rect zone = path.getBounds();
        double xScale = (zone.width + shadow.spreadRadius) / zone.width;
        double yScale = (zone.height + shadow.spreadRadius) / zone.height;
        Matrix4 m4 = Matrix4.identity();
        m4.translate(zone.width / 2, zone.height / 2);
        m4.scale(xScale, yScale);
        m4.translate(-zone.width / 2, -zone.height / 2);
        canvas.drawPath(
          path.shift(shadow.offset).transform(m4.storage),
          shadowPainter,
        );
      }
    }
    Paint whitePaint = Paint()..color = bgColor;
    canvas.drawPath(path, whitePaint);
  }

  @override
  bool shouldRepaint(covariant PainterBadgePaint oldDelegate) {
    return false;
  }
}
