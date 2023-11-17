import 'dart:math';

import 'package:flutter/material.dart';

class HandleWidget extends StatefulWidget {
  final double size;
  final double handleRadius;
  final void Function(double rotate, double distance) onMove; // 定义回调参数
  const HandleWidget({
    Key? key,
    this.size = 160.0,
    this.handleRadius = 20.0,
    required this.onMove,
  }) : super(key: key);

  @override
  _HandleWidgetState createState() => _HandleWidgetState();
}

class _HandleWidgetState extends State<HandleWidget> {
  final ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  reset(DragEndDetails details) {
    _offset.value = Offset.zero;

    widget.onMove(0, 0);
  }

  parser(DragUpdateDetails details) {
    final offset = details.localPosition;

    double dx = 0.0;
    double dy = 0.0;

    dx = offset.dx - widget.size / 2;

    dy = offset.dy - widget.size / 2;

    var rad = atan2(dx, dy); // tan(x,y) 正切

    if (dx < 0) {
      rad += 2 * pi;
    }

    var bgR = widget.size / 2 - widget.handleRadius;

    var thta = rad - pi / 2; // 旋转坐标系90度

    var d = sqrt(dx * dx + dy * dy);

    if (d > bgR) {
      dx = bgR * cos(thta);
      dy = -bgR * sin(thta);
    }

    widget.onMove(dx, dy); 

    _offset.value = Offset(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: reset,
      onPanUpdate: parser,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter:
            _HandlePainter(handleRadius: widget.handleRadius, offset: _offset),
      ),
    );
  }
}

class _HandlePainter extends CustomPainter {
  final Paint _paint = Paint();

  final ValueNotifier<Offset> offset;

  var handleRadius;

  final Color color;

  _HandlePainter(
      {this.color = Colors.blue, required this.offset, this.handleRadius})
      : super(repaint: offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    // canvas.drawRect(Rect.fromLTWH(0, 0, 160, 160), _paint);

    // canvas.drawPaint(
    //   Paint()..color = Colors.orange,
    // );

    final bgR = size.width / 2 - handleRadius; // 大圆的半径

    /// 将画布移动到中心点
    canvas.translate(size.width / 2, size.height / 2);

    _paint.style = PaintingStyle.fill;
    _paint.color = color.withAlpha(100);

    canvas.drawCircle(
      Offset.zero,
      bgR,
      _paint,
    );

    _paint.color = color.withAlpha(150);

    canvas.drawCircle(
      Offset(offset.value.dx, offset.value.dy),
      handleRadius,
      _paint,
    );

    _paint.color = color;
    _paint.style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset.zero,
      offset.value,
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant _HandlePainter oldDelegate) =>
      oldDelegate.handleRadius != handleRadius ||
      oldDelegate.offset != offset ||
      oldDelegate.color != color;
}
