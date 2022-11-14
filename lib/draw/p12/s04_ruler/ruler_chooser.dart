import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RulerChooser extends StatefulWidget {
  const RulerChooser({
    Key? key,
    this.size = const Size(240, 60),
    required this.onChanged,
    this.min = 100,
    this.max = 200,
  }) : super(key: key);

  /// 尺寸
  final Size size;

  /// 回调
  final void Function(double) onChanged;

  /// 最小值
  final int min;

  /// 最大值
  final int max;

  @override
  _RulerChooserState createState() => _RulerChooserState();
}

class _RulerChooserState extends State<RulerChooser> {
  ValueNotifier<double> _dx = ValueNotifier(0.0);

  double dx = 0;

  void _parser(DragUpdateDetails details) {
    dx += details.delta.dx;

    if (dx > 0) {
      dx = 0.0;
    }

    var limitMax = -(widget.max - widget.min) * (_kSpacer + _kStrokeWidth);

    if (dx < limitMax) {
      dx = limitMax;
    }
    _dx.value = dx;

    if (widget.onChanged != null) {
      widget.onChanged(details.delta.dx / (_kSpacer + _kStrokeWidth));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _parser,
      child: CustomPaint(
        size: widget.size,
        painter: _HandlePainter(
          dx: _dx,
          max: widget.max,
          min: widget.min,
        ),
      ),
    );
  }
}

/// 短线长
const double _kHeightLevel1 = 20;

/// 线长
const double _kHeightLevel2 = 25; // 5 线长

/// 线长
const double _kHeightLevel3 = 30; // 10 线长

/// 左侧偏移
const double _kPrefixOffSet = 5; // 左侧偏移

/// 线顶部偏移
const double _kVerticalOffSet = 12; // 线顶部偏移

/// 刻度宽
const double _kStrokeWidth = 2;

/// 刻度间隙
const double _kSpacer = 4;
const List<Color> _kRulerColors = [
  /// 渐变色
  Color(0xFF1426FB),
  Color(0xFF6080FB),
  Color(0xFFBEE0FB),
];

const List<double> _kRulerColorStops = [0.0, 0.2, 0.8];

class _HandlePainter extends CustomPainter {
  _HandlePainter({
    required this.dx,
    this.max,
    this.min,
  }) : super(repaint: dx) {
    _paint
      ..strokeWidth = _kStrokeWidth
      ..shader = ui.Gradient.radial(
        Offset.zero,
        25,
        _kRulerColors,
        _kRulerColorStops,
        TileMode.mirror,
      );

    _pointPaint
      ..color = Colors.purple
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
  }

  Paint _paint = Paint(); // 画笔
  Paint _pointPaint = Paint();

  late final ValueNotifier<double> dx;

  late final int? max;

  late final int? min;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    // canvas.drawPaint(Paint()..color = Colors.red);

    /// 绘制三角形
    _drawArrow(canvas);

    /// 将画布移动至指定点
    canvas.translate(dx.value, 0);

    /// 绘制尺子
    _drawRuler(canvas);
  }

  /// 绘制三角形
  void _drawArrow(Canvas canvas) {
    Path path = Path()
      ..moveTo(_kStrokeWidth / 2 + _kPrefixOffSet, 3)
      ..relativeLineTo(-3, 0)
      ..relativeLineTo(3, _kPrefixOffSet)
      ..relativeLineTo(3, -_kPrefixOffSet)
      ..close();

    canvas.drawPath(path, _pointPaint);
    canvas.translate(_kStrokeWidth / 2 + _kPrefixOffSet, _kVerticalOffSet);
  }

  /// 绘制刻度
  void _drawRuler(Canvas canvas) {
    double y = _kHeightLevel1;
    for (int i = min!; i < max! + 5; i++) {
      if (i % 5 == 0 && i % 10 != 0) {
        y = _kHeightLevel2;
      } else if (i % 10 == 0) {
        y = _kHeightLevel3;
        _simpleDrawText(
          canvas,
          i.toString(),
          offset: Offset(-3, _kHeightLevel3 + 5),
        );
      } else {
        y = _kHeightLevel1;
      }
      canvas.drawLine(Offset.zero, Offset(0, y), _paint);
      canvas.translate(_kStrokeWidth + _kSpacer, 0);
    }
  }

  /// 绘制文字
  void _simpleDrawText(Canvas canvas, String str,
      {Offset offset = Offset.zero}) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle())
      ..pushStyle(
        ui.TextStyle(
          color: Colors.black,
          textBaseline: ui.TextBaseline.alphabetic,
        ),
      )
      ..addText(str);

    canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(width: 11.0 * str.length)),
        offset);
  }

  @override
  bool shouldRepaint(covariant _HandlePainter oldDelegate) =>
      oldDelegate.dx != dx || oldDelegate.max != max || oldDelegate.min != min;
}
