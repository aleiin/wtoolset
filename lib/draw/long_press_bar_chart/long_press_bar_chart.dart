import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class LongPressBarChart extends StatefulWidget {
  const LongPressBarChart({
    Key? key,
    required this.data,
    this.width = 300,
    this.height = 350,
    this.tapOffset,
    this.longPressOffset,
    this.onTapOffsetCallBack,
  }) : super(key: key);

  /// 数据源
  final LongPressBarChartEntity data;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 点击坐标
  final ValueNotifier<Offset>? tapOffset;

  /// 长按坐标
  final ValueNotifier<Offset>? longPressOffset;

  /// 点击坐标回调
  final Function(Offset offset)? onTapOffsetCallBack;

  @override
  State<LongPressBarChart> createState() => _LongPressBarChartState();
}

class _LongPressBarChartState extends State<LongPressBarChart>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        // color: Colors.orange,
        // padding: const EdgeInsets.only(right: 20, bottom: 20, left: 40),

        child: LayoutBuilder(
          builder: (BuildContext _, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (TapDownDetails details) {
                // tapOffset.value = details.localPosition;
                widget.onTapOffsetCallBack?.call(details.localPosition);
              },
              onLongPressStart: (LongPressStartDetails details) {
                widget.longPressOffset?.value = details.localPosition;
              },
              onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
                widget.longPressOffset?.value = details.localPosition;
              },
              onLongPressEnd: (LongPressEndDetails details) {
                widget.longPressOffset?.value = details.localPosition;
              },
              onDoubleTap: () {
                widget.longPressOffset?.value = Offset.zero;
              },
              child: CustomPaint(
                painter: LongPressBarChartPainter(
                  data: widget.data,
                  animation: _controller,
                  tapOffset: widget.tapOffset,
                  longPressOffset: widget.longPressOffset,
                  bgColor: Theme.of(context).colorScheme.primary,
                  repaint: Listenable.merge([
                    _controller,
                    widget.tapOffset,
                    widget.longPressOffset,
                  ]),
                  onTap: (int index) {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

const double _kBarPadding = 10; // 柱状图前间隔

class LongPressBarChartPainter extends CustomPainter {
  LongPressBarChartPainter({
    required this.animation,
    required this.data,
    required this.repaint,
    this.tapOffset,
    this.longPressOffset,
    this.bgColor,
    this.auxiliaryLineColor = Colors.redAccent,
    this.onTap,
  })  : assert(data.xData.length == data.yData.length),
        super(repaint: repaint) {
    maxData = data.yData.reduce(max);
  }

  ///
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  ///
  final Animation<double> animation;

  /// 点击坐标
  final ValueNotifier<Offset>? tapOffset;

  /// 长按坐标
  final ValueNotifier<Offset>? longPressOffset;

  ///
  final Listenable repaint;

  /// 辅助线颜色
  final Color auxiliaryLineColor;

  ///
  double _kScaleWidth = 28; // 刻度高

  ///
  final double _kScaleHeight = 28; // 刻度高

  /// 删除的高度
  final double deleteDistance = 28;

  ///
  Path axisPath = Path();

  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;

  Paint fillPaint = Paint()..color = Colors.red;

  Paint linePaint = Paint()
    ..color = Colors.red
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  /// x 间隔
  double xStep = 0;

  /// y 间隔
  double yStep = 0;

  /// 数据最大值
  double maxData = 0;

  /// 折线点位信息
  final List<Offset> line = [];

  /// 数据源
  final LongPressBarChartEntity data;

  /// 背景颜色
  final Color? bgColor;

  // Path barPath = Path();

  /// *************碰撞测试**************

  ///
  final List<Path> paths = [];

  ///
  final List<Rect> rectPathList = [];

  ///
  Offset oldTapOffset = Offset.zero;

  ///
  final Function(int index)? onTap;

  @override
  void paint(Canvas canvas, Size size) {
    print('print 16:43: $longPressOffset');

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.blue.withOpacity(0.3),
    );

    findYMaxWidth();

    xStep = (size.width - _kScaleWidth) / data.xData.length;
    yStep = (size.height - _kScaleHeight - deleteDistance) / 5;

    canvas.translate(0, size.height);

    canvas.save();

    canvas.translate(_kScaleWidth, -_kScaleHeight);
    axisPath.moveTo(-_kScaleWidth, 0);
    axisPath.relativeLineTo(size.width, 0);
    axisPath.moveTo(0, _kScaleHeight);
    axisPath.relativeLineTo(0, -size.height);
    canvas.drawPath(axisPath, axisPaint);

    canvas.restore();

    drawYText(canvas, size);
    drawXText(canvas, size);
    // drawBarChart(canvas, size);
    drawBarChartPro(canvas, size);
    collectPoints(canvas, size);
    drawLineChart(canvas, size);

    /// 绘制点击辅助线
    // drawAuxiliaryLine(canvas, size);

    /// 绘制长按辅助线
    drawLongPressAuxiliaryLine(canvas, size);
  }

  /// 找出y轴上最大的宽度
  void findYMaxWidth() {
    ///
    final TextPainter textPainter =
        TextPainter(textDirection: TextDirection.ltr);

    final List<double> maxWidthList = [];

    double numStep = maxData / 5;

    for (int i = 0; i <= 5; i++) {
      String str = (numStep * i).toStringAsFixed(2);

      TextSpan text = TextSpan(
        text: str,
        style: const TextStyle(
          fontSize: 11,
        ),
      );

      textPainter.text = text;
      textPainter.layout(); // 进行布局

      Size size = textPainter.size;

      maxWidthList.add(size.width);
    }

    double maxWidth =
        maxWidthList.reduce((current, next) => current > next ? current : next);

    _kScaleWidth = maxWidth + 5;
  }

  /// 绘制辅助线
  void drawAuxiliaryLine(Canvas canvas, Size size) {
    if (tapOffset == null) {
      return;
    }

    canvas.save();

    Paint auxiliaryLinePaint = Paint()
      ..color = auxiliaryLineColor
      ..strokeWidth = 2;

    for (int i = 0; i < paths.length; i++) {
      if (paths[i].contains(tapOffset!.value)) {
        final point = line[i];
        final double yValue = data.yData[i];
        final String xValue = data.xData[i];

        /// 绘制x轴辅助线
        canvas.drawLine(
          Offset(0 + _kScaleWidth, point.dy),
          Offset(size.width, point.dy),
          auxiliaryLinePaint,
        );

        /// 绘制y轴辅助线
        canvas.drawLine(
          Offset(point.dx, -size.height),
          Offset(point.dx, 0 - _kScaleHeight),
          auxiliaryLinePaint,
        );

        canvas.drawCircle(point, 3, auxiliaryLinePaint);

        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: yValue.toStringAsFixed(2),
            style: const TextStyle(fontSize: 11, color: Colors.white),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(); // 进行布局
        Size textSize = textPainter.size; // 尺寸必须在布局后获取

        canvas.drawRect(
            Rect.fromLTWH(
              0 + _kScaleWidth - textSize.width - 2,
              point.dy - textSize.height / 2,
              textSize.width,
              textSize.height,
            ),
            auxiliaryLinePaint..color = auxiliaryLineColor);

        textPainter.paint(
          canvas,
          Offset(
            0 + _kScaleWidth - textSize.width - 2,
            point.dy - textSize.height / 2,
          ),
        ); // 进行绘制

        textPainter.text = TextSpan(
          text: xValue,
          style: const TextStyle(fontSize: 11, color: Colors.white),
        );

        textPainter.layout();

        Size textXSize = textPainter.size; // 尺寸必须在布局后获取

        canvas.drawRect(
            Rect.fromLTWH(
              point.dx - textXSize.width / 2,
              0 - _kScaleHeight + 5,
              textXSize.width,
              textXSize.height,
            ),
            auxiliaryLinePaint..color = auxiliaryLineColor);

        textPainter.paint(canvas,
            Offset(point.dx - textXSize.width / 2, 0 - _kScaleHeight + 5));
      }
    }

    canvas.restore();
  }

  /// 绘制长按时的辅助线颜色
  void drawLongPressAuxiliaryLine(Canvas canvas, Size size) {
    if (longPressOffset == null || longPressOffset?.value == Offset.zero) {
      return;
    }

    canvas.save();

    canvas.translate(0, -size.height);

    // drawAssistCircle(
    //   canvas,
    //   size,
    // );

    // drawAssistCircle(canvas, size, offset: longPressOffset?.value);
    drawAssistCircle(canvas, size, offset: Offset(size.width, size.height));

    print('print 18:01: ${longPressOffset?.value}');

    Paint auxiliaryLinePaint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2;

    if (longPressOffset!.value.dx < _kScaleWidth ||
        longPressOffset!.value.dx > size.width) {
      /// 判断左右边界

      /// 绘制x轴
      canvas.drawLine(
        Offset(0 + _kScaleWidth, longPressOffset!.value.dy),
        Offset(size.width, longPressOffset!.value.dy),
        auxiliaryLinePaint,
      );

      if (longPressOffset!.value.dx < _kScaleWidth) {
        /// 绘制y轴
        canvas.drawLine(
          Offset(_kScaleWidth, size.height - _kScaleHeight),
          Offset(_kScaleWidth, 0),
          auxiliaryLinePaint,
        );
      } else if (longPressOffset!.value.dx > size.width) {
        /// 绘制y轴
        canvas.drawLine(
          Offset(size.width, size.height - _kScaleHeight),
          Offset(size.width, 0),
          auxiliaryLinePaint,
        );
      }
    } else if (longPressOffset!.value.dy <= 0 ||
        longPressOffset!.value.dy > (size.height - _kScaleHeight)) {
      /// 判断上下边界

      if (longPressOffset!.value.dy <= 0) {
        /// 绘制x轴
        canvas.drawLine(
          Offset(0 + _kScaleWidth, 0),
          Offset(size.width, 0),
          auxiliaryLinePaint,
        );
      } else if (longPressOffset!.value.dy > (size.height - _kScaleHeight)) {
        /// 绘制x轴
        canvas.drawLine(
          Offset(0 + _kScaleWidth, size.height - _kScaleHeight),
          Offset(size.width, size.height - _kScaleHeight),
          auxiliaryLinePaint,
        );
      }

      /// 绘制y轴
      canvas.drawLine(
        Offset(longPressOffset!.value.dx, size.height - _kScaleHeight),
        Offset(longPressOffset!.value.dx, 0),
        auxiliaryLinePaint,
      );
    }
    // else if (longPressOffset!.value.dx < _kScaleWidth &&
    //     longPressOffset!.value.dy > (size.height - _kScaleHeight)) {
    //   /// 绘制x轴
    //   canvas.drawLine(
    //     Offset(0 + _kScaleWidth, size.height - _kScaleHeight),
    //     Offset(size.width, size.height - _kScaleHeight),
    //     auxiliaryLinePaint,
    //   );
    //
    //   /// 绘制y轴
    //   canvas.drawLine(
    //     Offset(_kScaleWidth, size.height - _kScaleHeight),
    //     Offset(_kScaleWidth, 0),
    //     auxiliaryLinePaint,
    //   );
    // }
    else {
      /// 绘制x轴
      canvas.drawLine(
        Offset(0 + _kScaleWidth, longPressOffset!.value.dy),
        Offset(size.width, longPressOffset!.value.dy),
        auxiliaryLinePaint,
      );

      /// 绘制y轴
      canvas.drawLine(
        Offset(longPressOffset!.value.dx, size.height - _kScaleHeight),
        Offset(longPressOffset!.value.dx, 0),
        auxiliaryLinePaint,
      );
    }

    // for (int i = 0; i < paths.length; i++) {
    //   final point = line[i];
    //   final double yValue = data.yData[i];
    //   final String xValue = data.xData[i];
    //
    //   /// 绘制x轴
    //   canvas.drawLine(
    //     Offset(0 + _kScaleWidth, longPressOffset!.value.dy),
    //     Offset(size.width, longPressOffset!.value.dy),
    //     auxiliaryLinePaint,
    //   );
    //
    //   /// 绘制y轴
    //   canvas.drawLine(
    //     Offset(longPressOffset!.value.dx, -size.height),
    //     Offset(longPressOffset!.value.dx, 0 - _kScaleHeight),
    //     auxiliaryLinePaint,
    //   );
    //
    //   canvas.drawCircle(point, 3, auxiliaryLinePaint);
    //
    //   TextPainter textPainter = TextPainter(
    //     text: TextSpan(
    //       text: yValue.toStringAsFixed(2),
    //       style: const TextStyle(fontSize: 11, color: Colors.white),
    //     ),
    //     textAlign: TextAlign.center,
    //     textDirection: TextDirection.ltr,
    //   );
    //
    //   textPainter.layout(); // 进行布局
    //   Size textSize = textPainter.size; // 尺寸必须在布局后获取
    //
    //   canvas.drawRect(
    //       Rect.fromLTWH(
    //         0 + _kScaleWidth - textSize.width - 2,
    //         point.dy - textSize.height / 2,
    //         textSize.width,
    //         textSize.height,
    //       ),
    //       auxiliaryLinePaint..color = auxiliaryLineColor);
    //
    //   textPainter.paint(
    //     canvas,
    //     Offset(
    //       0 + _kScaleWidth - textSize.width - 2,
    //       point.dy - textSize.height / 2,
    //     ),
    //   ); // 进行绘制
    //
    //   textPainter.text = TextSpan(
    //     text: xValue,
    //     style: const TextStyle(fontSize: 11, color: Colors.white),
    //   );
    //
    //   textPainter.layout();
    //
    //   Size textXSize = textPainter.size; // 尺寸必须在布局后获取
    //
    //   canvas.drawRect(
    //       Rect.fromLTWH(
    //         point.dx - textXSize.width / 2,
    //         0 - _kScaleHeight + 5,
    //         textXSize.width,
    //         textXSize.height,
    //       ),
    //       auxiliaryLinePaint..color = auxiliaryLineColor);
    //
    //   textPainter.paint(canvas,
    //       Offset(point.dx - textXSize.width / 2, 0 - _kScaleHeight + 5));
    // }

    canvas.translate(0, size.height);
    canvas.restore();
  }

  /// 绘制辅助圆
  void drawAssistCircle(
    Canvas canvas,
    Size size, {
    Color? color,
    Offset? offset,
  }) {
    canvas.drawCircle(
      offset ?? Offset.zero,
      5,
      Paint()..color = color ?? Colors.red,
    );
  }

  void drawXText(Canvas canvas, Size size) {
    canvas.save();

    canvas.translate(xStep + _kScaleWidth, -_kScaleHeight);

    for (int i = 0; i < data.xData.length; i++) {
      // canvas.drawLine(
      //   const Offset(0, 0),
      //   const Offset(0, _kScaleHeight),
      //   axisPaint,
      // );

      _drawAxisText(
        canvas,
        data.xData[i],
        alignment: Alignment.center,
        offset: Offset(-xStep / 2, 10),
      );

      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  /// 找点
  void collectPoints(Canvas canvas, Size size) {
    canvas.save();

    line.clear();

    for (int i = 0; i < data.xData.length; i++) {
      double dataHeight = -(data.yData[i] /
              maxData *
              (size.height - _kScaleHeight - deleteDistance)) -
          _kScaleHeight;

      if (dataHeight.isNaN) {
        dataHeight = 0.0;
      }

      line.add(Offset((_kScaleWidth + xStep * i + (xStep / 2)), dataHeight));
    }

    canvas.restore();
  }

  /// 绘制柱形图
  void drawBarChartPro(Canvas canvas, Size size) {
    canvas.save();

    fillPaint.color = bgColor ?? Colors.lightBlue;

    canvas.translate(0, -size.height);

    paths.clear();

    for (int i = 0; i < data.xData.length; i++) {
      Path barPath = Path();

      double dataHeight = (data.yData[i] /
          maxData *
          (size.height - _kScaleHeight - deleteDistance));

      barPath
        ..moveTo(xStep * i + _kBarPadding + _kScaleWidth,
            size.height - _kScaleHeight)
        ..relativeLineTo(0, -dataHeight * animation.value)
        ..relativeLineTo(xStep - (2 * _kBarPadding), 0)
        ..relativeLineTo(0, dataHeight * animation.value)
        ..close();

      paths.add(barPath);

      canvas.drawPath(
        barPath,
        fillPaint,
      );
    }

    canvas.restore();
  }

  /// 绘制柱形图
  void drawBarChart(Canvas canvas, Size size) {
    fillPaint.color = bgColor ?? Colors.lightBlue;
    canvas.save();
    canvas.translate(xStep, 0);

    rectPathList.clear();

    for (int i = 0; i < data.xData.length; i++) {
      double dataHeight =
          -(data.yData[i] / maxData * (size.height - _kScaleHeight));

      if (!dataHeight.isNaN) {
        final Rect rectPath = Rect.fromLTWH(
          _kBarPadding,
          0,
          xStep - 2 * _kBarPadding,
          dataHeight * animation.value,
        ).translate(-xStep, 0);

        rectPathList.add(rectPath);

        canvas.drawRect(
          rectPath,
          fillPaint,
        );
      }

      canvas.translate(xStep, 0);
    }

    canvas.restore();
  }

  /// 绘制连线
  void drawLineChart(Canvas canvas, Size size) {
    canvas.drawPoints(PointMode.points, line, linePaint..strokeWidth = 5);

    Offset p1 = line[0];

    Path path = Path()..moveTo(p1.dx, p1.dy);

    for (var i = 1; i < line.length; i++) {
      path.lineTo(line[i].dx, line[i].dy);
    }

    linePaint.strokeWidth = 1;

    PathMetrics pms = path.computeMetrics();
    for (var pm in pms) {
      canvas.drawPath(
          pm.extractPath(0, pm.length * animation.value), linePaint);
    }
  }

  /// 绘制Y轴
  void drawYText(Canvas canvas, Size size) {
    canvas.save();

    canvas.translate(0, -_kScaleHeight);

    double numStep = maxData / 5;

    for (int i = 0; i <= 5; i++) {
      if (i == 0) {
        // _drawAxisText(canvas, '0', offset: const Offset(-10, 2));
        canvas.translate(_kScaleWidth, -yStep);
        continue;
      }

      canvas.drawLine(
        const Offset(0, 0),
        Offset(size.width - _kScaleWidth, 0),
        gridPaint,
      );

      // canvas.drawLine(
      //   const Offset(-_kScaleHeight, 0),
      //   const Offset(0, 0),
      //   axisPaint,
      // );

      String str = (numStep * i).toStringAsFixed(2);

      _drawAxisText(canvas, str, offset: const Offset(-2, 0));

      canvas.translate(0, -yStep);
    }

    canvas.restore();
  }

  void _drawAxisText(
    Canvas canvas,
    String str, {
    Color color = Colors.black,
    bool x = false,
    Alignment alignment = Alignment.centerRight,
    Offset offset = Offset.zero,
  }) {
    TextSpan text = TextSpan(
      text: str,
      style: TextStyle(
        fontSize: 11,
        color: color,
      ),
    );

    _textPainter.text = text;
    _textPainter.layout(maxWidth: _kScaleHeight * 2); // 进行布局

    Size size = _textPainter.size;

    Offset offsetPos = Offset(-size.width / 2, -size.height / 2).translate(
      -size.width / 2 * alignment.x + offset.dx,
      0.0 + offset.dy,
    );

    _textPainter.paint(canvas, offsetPos);
  }

  @override
  bool shouldRepaint(covariant LongPressBarChartPainter oldDelegate) =>
      oldDelegate.repaint != repaint;

  @override
  bool hitTest(Offset position) {
    if (oldTapOffset.dx == position.dx && oldTapOffset.dy == position.dy) {
      return false;
    }

    oldTapOffset = position;

    for (int i = 0; i < paths.length; i++) {
      if (paths[i].contains(position)) {
        onTap?.call(i);
        oldTapOffset = position;

        return true;
      }
    }

    onTap?.call(-1);

    return false;
  }
}

class LongPressBarChartEntity {
  LongPressBarChartEntity({
    required this.xData,
    required this.yData,
  });

  final List<String> xData;

  final List<double> yData;
}
