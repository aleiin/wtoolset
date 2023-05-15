import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/common/coordinate.dart';
import 'package:wtoolset/draw/study/p14/s02/touch_info.dart';

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  final TouchInfo touchInfo = TouchInfo();

  @override
  void initState() {
    print('print 23:30: ${Offset(1, 1) * 100}');
    super.initState();
  }

  void _onPanDown(DragDownDetails details) {
    if (touchInfo.points.length < 3) {
      touchInfo.addPoint(details.localPosition);
    } else {
      judgeZone(details.localPosition);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    judgeZone(details.localPosition, update: true);
  }

  /// 判断出是否在某点的半径为r圆范围内
  bool judgeCircleArea(Offset src, Offset dst, double r) =>
      (src - dst).distance <= r;

  void judgeZone(Offset src, {bool update = false}) {
    for (int i = 0; i < touchInfo.points.length; i++) {
      if (judgeCircleArea(src, touchInfo.points[i], 15)) {
        touchInfo.selectIndex = i;
        if (update) {
          touchInfo.updatePoint(i, src);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: _onPanDown,
      onPanUpdate: _onPanUpdate,
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: PaperPainter(repaint: touchInfo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    touchInfo.dispose();
    super.dispose();
  }
}

class PaperPainter extends CustomPainter {
  /// 坐标系
  Coordinate coordinate = Coordinate();

  late List<Offset> _pos;

  /// 辅助画笔
  Paint _helpPaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  late final TouchInfo? repaint;

  PaperPainter({this.repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);

    canvas.translate(size.width / 2, size.height / 2);

    _pos = repaint!.points
        .map((e) => e.translate(-size.width / 2, -size.height / 2))
        .toList();

    Path path = Path();

    Paint _paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    if (_pos.length < 3) {
      canvas.drawPoints(PointMode.points, _pos, _paint..strokeWidth = 8);
    } else {
      path.moveTo(_pos[0].dx, _pos[0].dy);
      path.quadraticBezierTo(_pos[1].dx, _pos[1].dy, _pos[2].dx, _pos[2].dy);
      canvas.drawPath(path, _paint);
      _drawHelp(canvas);
      _drawSelectPos(canvas, size);
    }
  }

  void _drawHelp(Canvas canvas) {
    _helpPaint..color = Colors.purple;
    canvas.drawPoints(PointMode.polygon, _pos, _helpPaint..strokeWidth = 1);
    canvas.drawPoints(PointMode.points, _pos, _helpPaint..strokeWidth = 8);
  }

  void _drawSelectPos(Canvas canvas, Size size) {
    Offset? selectPos = repaint!.selectPoint;
    if (selectPos == null) {
      return;
    }

    selectPos = selectPos.translate(-size.width / 2, -size.height / 2);

    canvas.drawCircle(
        selectPos,
        10,
        _helpPaint
          ..color = Colors.green
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
