import 'package:flutter/material.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/axis_range.dart';

class CustomCoordinate {
  CustomCoordinate({
    this.range = const AxisRange(),
    this.color = Colors.black,
    this.strokeWidth = 1,
    this.xScaleCount = 10,
    this.yScaleCount = 10,
  }) {
    axisPainter
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
  }

  ///
  AxisRange range;

  ///
  final Color color;

  ///
  final double strokeWidth;

  ///
  final int xScaleCount;

  ///
  final int yScaleCount;

  ///
  final Paint axisPainter = Paint();

  ///
  final Paint gridPainter = Paint()
    ..color = Colors.grey
    ..strokeWidth = 0.5;

  ///
  TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  double scaleHeight = 100;
  double scaleWidth = 100;

  ///
  void paint(Canvas canvas, Size size) {
    _drawAxis(canvas, size);

    /// 计算步长
    double stepX = range.xSpan / xScaleCount;

    for (int i = 0; i <= xScaleCount; i++) {
      /// 显示的文字
      double value = range.minX + stepX * i;

      double offsetX = (value - range.minX) / range.xSpan * size.width;

      textPainter.text = TextSpan(
        text: value.toStringAsFixed(2),
        style: const TextStyle(fontSize: 12, color: Colors.black),
      );

      textPainter.layout();

      textPainter.paint(
          canvas, Offset(offsetX - textPainter.size.width / 2, 5));

      // canvas.drawLine(Offset(i * stepX, 0), Offset(i * stepX, 5), axisPainter);

      canvas.drawLine(
          Offset(offsetX, 0), Offset(offsetX, -size.height), gridPainter);
    }

    double stepY = range.ySpan / yScaleCount;

    for (int i = 0; i <= yScaleCount; i++) {
      // String value = (i / yScaleCount).toStringAsFixed(2);

      double value = range.minY + i * stepY;

      double offsetY = (value - range.minY) / range.ySpan * size.height;

      textPainter.text = TextSpan(
        text: value.toStringAsFixed(2),
        style: const TextStyle(fontSize: 12, color: Colors.black),
      );

      textPainter.layout();

      textPainter.paint(
          canvas,
          Offset(-textPainter.size.width - 10,
              -(offsetY + textPainter.size.height / 2)));

      // canvas.drawLine(
      //     Offset(0, -i * stepY), Offset(-5, -i * stepY), axisPainter);

      canvas.drawLine(
          Offset(0, -offsetY), Offset(size.width, -offsetY), gridPainter);
    }

    // textPainter.text = const TextSpan(
    //   text: '0',
    //   style: TextStyle(fontSize: 12, color: Colors.black),
    // );
    //
    // textPainter.layout();
    //
    // textPainter.paint(canvas, const Offset(-5, 5));
  }

  /// 绘制x和y轴
  void _drawAxis(Canvas canvas, Size size) {
    Path axisPath = Path();

    /// 绘制x坐标
    axisPath.relativeLineTo(size.width, 0);
    axisPath.relativeLineTo(-10, -4);
    axisPath.moveTo(size.width, 0);
    axisPath.relativeLineTo(-10, 4);

    /// 绘制y坐标
    axisPath.moveTo(0, 0);
    axisPath.relativeLineTo(0, -size.height);
    axisPath.relativeLineTo(-4, 10);
    axisPath.moveTo(0, -size.height);
    axisPath.relativeLineTo(4, 10);

    canvas.drawPath(axisPath, axisPainter);

    // textPainter.text = const TextSpan(
    //   text: "x轴",
    //   style: TextStyle(fontSize: 12, color: Colors.black),
    // );
    //
    // textPainter.layout();
    //
    // Size textSize = textPainter.size;
    //
    // textPainter.paint(canvas, Offset(size.width - textSize.width, 5));
    //
    // textPainter.text = const TextSpan(
    //   text: "y轴",
    //   style: TextStyle(fontSize: 12, color: Colors.black),
    // );
    //
    // textPainter.layout();
    //
    // Size textSizeY = textPainter.size;
    //
    // textPainter.paint(
    //   canvas,
    //   Offset(-textSizeY.width + textSizeY.width / 2,
    //       -size.height - textSizeY.height - 3),
    // );
  }

  Offset real(Offset p, Size size) {
    double x = (p.dx - range.minX) / range.xSpan * size.width;
    double y = (p.dy - range.minY) / range.ySpan * size.height;
    return Offset(x, y);
  }

  void move(Offset offset) {
    range = AxisRange(
      minY: range.minY + offset.dy,
      maxY: range.maxY + offset.dy,
      minX: range.minX + offset.dx,
      maxX: range.maxX + offset.dx,
    );
  }

  void scale(double rate) {
    range = AxisRange(
      minY: range.minY * rate,
      maxY: range.maxY * rate,
      minX: range.minX * rate,
      maxX: range.maxX * rate,
    );
    scaleHeight *= rate;
    scaleWidth *= rate;
    if (scaleHeight > 200) {
      scaleHeight = scaleHeight / 2;
    }
    if (scaleWidth > 200) {
      scaleWidth = scaleWidth / 2;
    }
    if (scaleWidth < 80) {
      scaleWidth = scaleWidth * 2;
    }
    if (scaleHeight < 80) {
      scaleHeight = scaleHeight * 2;
    }
  }
}
