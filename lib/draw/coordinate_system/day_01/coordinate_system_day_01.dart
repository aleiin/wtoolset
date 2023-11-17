import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/axis_range.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/custom_coordinate.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/fun.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/function_manager.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/point_values.dart';

void main() {
  runApp(const CoordinateSystemDay01());
}

class CoordinateSystemDay01 extends StatelessWidget {
  const CoordinateSystemDay01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "day01",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PointValues pointValues = PointValues();
  final FunctionManager fm = FunctionManager();
  final CustomCoordinate coordinate = CustomCoordinate(
      xScaleCount: 5,
      yScaleCount: 5,
      range: const AxisRange(
        minX: 0,
        maxX: 7.8,
        minY: 0,
        maxY: 7.8,
      ));

  @override
  void initState() {
    super.initState();

    fm.add(
        Fun(fx: (x) => 6 * sin(0.5 * x), color: Colors.blue, strokeWidth: 2));
    fm.add(Fun(fx: (x) => x, color: Colors.red, strokeWidth: 2));
    fm.add(
        Fun(fx: (x) => x * x * x / 20, color: Colors.purple, strokeWidth: 2));
    fm.add(Fun(fx: (x) => x * x, color: Colors.yellow, strokeWidth: 2));
    fm.add(Fun(fx: (x) => 4.5, color: Colors.green, strokeWidth: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("坐标系绘制"),
      ),
      body: Column(
        children: [
          Wrap(
            spacing: 10,
            children: [
              OutlinedButton(
                onPressed: () {
                  coordinate.range = const AxisRange(
                    minX: -10,
                    maxX: 10,
                    minY: -10,
                    maxY: 10,
                  );
                  pointValues.repaint();
                },
                child: const Text('复原'),
              ),
              OutlinedButton(
                onPressed: () {
                  coordinate.scale(0.9);
                  pointValues.repaint();
                },
                child: const Text('放大'),
              ),
              OutlinedButton(
                onPressed: () {
                  coordinate.scale(1.1);
                  pointValues.repaint();
                },
                child: const Text('缩小'),
              ),
            ],
          ),
          const SizedBox(height: 50),
          GestureDetector(
            // onPanUpdate: _onPanUpdate,
            onDoubleTap: _clear,
            onScaleUpdate: _onScaleUpdate,
            child: Center(
              child: CustomPaint(
                size: Size(MediaQueryData.fromWindow(window).size.width / 1.5,
                    MediaQueryData.fromWindow(window).size.height / 2),
                painter: PainterBox(
                  customCoordinate: coordinate,
                  fm: fm,
                  points: pointValues,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clear() {
    pointValues.clear();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double rate = coordinate.range.xSpan / 2 * 0.002;
    coordinate.move(details.delta.scale(-rate, rate));
    pointValues.repaint();
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    print('print 17:17: $details');
    coordinate.scale(details.scale);
    pointValues.repaint();
    // double rate = coordinate.range.xSpan / 2 * 0.002;
    // coordinate.move(details.delta.scale(-rate, rate));
    // pointValues.repaint();
  }
}

class PainterBox extends CustomPainter {
  PainterBox({
    required this.customCoordinate,
    required this.fm,
    required this.points,
  }) : super(repaint: points);

  ///
  final CustomCoordinate customCoordinate;

  ///
  final FunctionManager fm;

  ///
  final PointValues points;

  ///
  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.2);

  ///
  final Paint _mainPainter = Paint()..color = Colors.blue;

  ///
  final Paint axisPainter = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke;

  ///
  TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  // final CustomCoordinate customCoordinate = CustomCoordinate(
  //   range: const range(minX: -1, maxX: 1, minY: -1, maxY: 1),
  //   color: Colors.red,
  //   xScaleCount: 10,
  //   yScaleCount: 10,
  // );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    customCoordinate.paint(canvas, size);
    canvas.scale(1, -1);

    canvas.drawRect(Offset.zero & size, _bgPainter);

    // _drawPoint(canvas, size);
    _drawFn(canvas, size);
    _drawFn1(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  ///
  void _drawPoint(Canvas canvas, Size size) {
    Offset p = const Offset(0.6, 0.6);

    double x = (p.dx - customCoordinate.range.minX) /
        customCoordinate.range.xSpan *
        size.width;

    double y = (p.dy - customCoordinate.range.minY) /
        customCoordinate.range.ySpan *
        size.height;

    canvas.drawCircle(Offset(x, y), 5, _mainPainter);
  }

  void _drawFn(
    Canvas canvas,
    Size size,
  ) {
    List<Offset> points = [];
    int pointCount = 500;
    double step = customCoordinate.range.xSpan / pointCount;
    for (int i = 0; i < pointCount; i++) {
      double dx = customCoordinate.range.minX + step * i;
      double dy = 0.6 * sin(dx * 5);
      double x = (dx - customCoordinate.range.minX) /
          customCoordinate.range.xSpan *
          size.width;
      double y = (dy - customCoordinate.range.minY) /
          customCoordinate.range.ySpan *
          size.height;
      points.add(Offset(x, y));
    }
    canvas.drawPoints(
        PointMode.polygon, points, _mainPainter..color = Colors.blue);
  }

  void _drawFn1(
    Canvas canvas,
    Size size,
  ) {
    List<Offset> points = [];
    int pointCount = 500;
    double step = customCoordinate.range.xSpan / pointCount;
    for (int i = 0; i < pointCount; i++) {
      double dx = customCoordinate.range.minX + step * i;
      double dy = dx;
      double x = (dx - customCoordinate.range.minX) /
          customCoordinate.range.xSpan *
          size.width;
      double y = (dy - customCoordinate.range.minY) /
          customCoordinate.range.ySpan *
          size.height;
      points.add(Offset(x, y));
    }
    canvas.drawPoints(
        PointMode.polygon, points, _mainPainter..color = Colors.blue);
  }
}
