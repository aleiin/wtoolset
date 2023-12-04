import 'package:flutter/material.dart';

class PainterBadgePaint extends CustomPainter {
  const PainterBadgePaint({
    this.bgColor = Colors.blue,
    this.text = '角标',
    this.textStyle,
    this.horizontal = 2,
    this.vertical = 4,
    this.alignment = Alignment.centerLeft,
    this.isQuadraticBezier = true,
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

  /// 是否使用贝塞尔曲线
  /// true: 使用贝塞尔
  /// false: 使用圆弧进行绘制
  final bool isQuadraticBezier;

  /// 阴影
  final List<BoxShadow> shadows;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

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

    if (isQuadraticBezier) {
      /// 使用贝塞尔曲线来绘制

      path.relativeQuadraticBezierTo(width, 0, width, width);

      path.relativeLineTo(0, textHeight);

      path.relativeQuadraticBezierTo(0, -width, -width, -width);

      path.relativeLineTo(-textWidth, 0);

      path.relativeQuadraticBezierTo(-width, 0, -width, -width);

      path.relativeQuadraticBezierTo(0, -width, width, -width);
    } else {
      /// 使用圆弧来绘制

      path.relativeArcToPoint(
        Offset(width, width),
        radius: Radius.circular(textHeight / 2),

        /// 是否使用优弧
        largeArc: false,

        /// 是否顺时针
        clockwise: true,
      );

      path.relativeLineTo(0, textHeight);

      path.relativeArcToPoint(
        Offset(-width, -width),
        radius: Radius.circular(textHeight / 2),

        /// 是否使用优弧
        largeArc: false,

        /// 是否顺时针
        clockwise: false,
      );

      path.relativeLineTo(-textWidth, 0);

      path.relativeArcToPoint(
        Offset(0, -textHeight),
        radius: Radius.circular(textHeight / 2),

        /// 是否使用优弧
        largeArc: true,

        /// 是否顺时针
        clockwise: true,
      );
    }

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
