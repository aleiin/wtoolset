
import 'package:flutter/material.dart';

/// 基础坐标轴
@immutable
class Coordinate {
  final double step;
  final double strokeWidth;
  final Color axisColor;
  final Color gridColor;
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  Coordinate({
    this.step = 20,
    this.strokeWidth = 0.5,
    this.axisColor = Colors.blue,
    this.gridColor = Colors.grey,
  });

  final Paint _gridPint = Paint();
  final Path _gridPath = Path();

  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGridLine(canvas, size);
    // _drawGrid(canvas, size);
    _drawAxis(canvas, size);
    _drawText(canvas, size);
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    _gridPint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = gridColor;
    _drawBottomRight(canvas, size);

    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(const Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, step);
    }

    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset.zero, Offset(0, size.height / 2), _gridPint);
      canvas.translate(step, 0);
    }

    canvas.restore();
  }

  /// 画轴
  void _drawAxis(Canvas canvas, Size size) {
    _gridPint
      ..strokeWidth = 1.5
      ..color = axisColor;

    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _gridPint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _gridPint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), _gridPint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), _gridPint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _gridPint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _gridPint);
  }

  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.black, String x = "x"}) {
    /// 文字对象
    TextSpan text = TextSpan(
      text: str,
      style: TextStyle(
        fontSize: 11,
        color: color,
      ),
    );

    /// 将文字赋给TextPainter对象
    _textPainter.text = text;

    /// 进行布局
    _textPainter.layout();

    /// 获取TextPainter对象的大小
    Size size = _textPainter.size;

    Offset offset = Offset.zero;

    if (x == "zero") {
      offset = Offset(-size.width / 2 * 2.5, -size.height / 2 * -0.5);
    } else if (x == "x") {
      offset = Offset(-size.width / 2, size.height / 2);
    } else {
      offset = Offset(size.height / 2, -size.height / 2 + 2);
    }

    _textPainter.paint(canvas, offset);
  }

  void _drawText(Canvas canvas, Size size) {
    /// y > 0
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, step);
        continue;
      } else {
        var str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: "y");
      }
      canvas.translate(0, step);
    }
    canvas.restore();

    /// x > 0
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (i == 0) {
        _drawAxisText(canvas, "0", color: Colors.black, x: "zero");
        canvas.translate(step, 0);
        continue;
      }
      if (step < 30 && i.isOdd) {
        canvas.translate(step, 0);
        continue;
      } else {
        var str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: "x");
      }
      canvas.translate(step, 0);
    }
    canvas.restore();

    /// y < 0
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: "y");
      }
      canvas.translate(0, -step);
    }
    canvas.restore();

    /// x < 0
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(-step, 0);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: "x");
      }
      canvas.translate(-step, 0);
    }
    canvas.restore();
  }

  void _drawGridLine(Canvas canvas, Size size) {
    _gridPint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = gridColor;

    for (int i = 0; i < size.width / 2 / step; i++) {
      _gridPath.moveTo(step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
      _gridPath.moveTo(-step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      _gridPath.moveTo(-size.width / 2, step * i);
      _gridPath.relativeLineTo(size.width, 0);
      _gridPath.moveTo(-size.width / 2, -step * i);
      _gridPath.relativeLineTo(size.width, 0);
    }

    canvas.drawPath(_gridPath, _gridPint);
  }
}
