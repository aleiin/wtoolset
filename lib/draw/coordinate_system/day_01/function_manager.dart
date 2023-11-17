import 'dart:ui';

import 'package:wtoolset/draw/coordinate_system/day_01/custom_coordinate.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/fun.dart';

class FunctionManager {
  final List<Fun> _funList = [];

  final Paint _mainPainter = Paint();

  void add(Fun fun) {
    _funList.add(fun);
  }

  void draw(Canvas canvas, Size size, CustomCoordinate coordinate) {
    for (Fun fun in _funList) {
      drawFx(canvas, size, coordinate, fun);
    }
  }

  void drawFx(Canvas canvas, Size size, CustomCoordinate coordinate, Fun fun) {
    List<Offset> points = [];
    double step = coordinate.range.xSpan / fun.pointCount;
    for (int i = 0; i < fun.pointCount; i++) {
      double dx = coordinate.range.minX + step * i;
      double dy = fun.fx(dx);
      points.add(coordinate.real(Offset(dx, dy), size));
    }
    canvas.drawPoints(
      PointMode.polygon,
      points,
      _mainPainter
        ..color = fun.color
        ..strokeWidth = fun.strokeWidth,
    );
  }
}
