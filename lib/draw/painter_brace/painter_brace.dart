import 'package:flutter/material.dart';

/// 自绘大括号
/// https://stackoverflow.com/questions/56723258/flutter-curve-bar
class PainterBrace extends StatelessWidget {
  const PainterBrace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自绘大括号'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 80),
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          alignment: Alignment.center,
          decoration: const ShapeDecoration(
            shape: CustomShapeBorder(),
            //color: Colors.orange,
            gradient: LinearGradient(colors: [Colors.blue, Colors.orange]),
            shadows: [
              BoxShadow(
                  color: Colors.black, offset: Offset(3, -3), blurRadius: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomShapeBorder extends ShapeBorder {
  const CustomShapeBorder();

  Path _getPath(Rect rect) {
    final r = rect.height / 2;
    final radius = Radius.circular(r);
    final offset = Rect.fromCircle(center: Offset.zero, radius: r);
    return Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..relativeArcToPoint(offset.bottomRight, clockwise: false, radius: radius)
      ..lineTo(rect.center.dx - r, rect.center.dy)
      ..relativeArcToPoint(offset.bottomRight, clockwise: true, radius: radius)
      ..relativeArcToPoint(offset.topRight, clockwise: true, radius: radius)
      ..lineTo(rect.centerRight.dx - r, rect.centerRight.dy)
      ..relativeArcToPoint(offset.topRight, clockwise: false, radius: radius)
      ..addRect(rect);
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.all(0);
  }

  @override
  ShapeBorder scale(double t) {
    return const CustomShapeBorder();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}
