// import 'dart:ui';
// import 'package:flutter/material.dart';
//
// class PathAnimation extends StatefulWidget {
//   @override
//   _PathAnimationState createState() => _PathAnimationState();
// }
//
// class _PathAnimationState extends State<PathAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation _animation;
//   double _fraction = 0.0;
//   int _seconds = 6;
//   late Path _path;
//   GlobalKey _canvasKey = GlobalKey();
//
//   @override
//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: _seconds));
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Path Animation'),
//       ),
//       body: Container(
//         color: Colors.grey,
//         child: Column(
//           children: <Widget>[
//             CustomPaint(
//               painter: PathPainter(_path, _fraction),
//               child: Container(
//                 key: _canvasKey,
//                 height: 500.0,
//               ),
//             ),
//             RaisedButton(
//               onPressed: _startAnimation,
//               child: Text('Go'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Path _getPath(Size size) {
//     Path path = Path();
//     path.moveTo(0, size.height / 2);
//     // path.quadraticBezierTo(
//     //     size.width / 2, size.height, size.width, size.height / 2);
//     path.cubicTo(size.width / 4, 3 * size.height / 4, 3 * size.width / 4,
//         size.height / 4, size.width, size.height);
//
//     return path;
//   }
//
//   _startAnimation() {
//     RenderObject? renderBox = _canvasKey.currentContext!.findRenderObject();
//     Size s = renderBox!.size;
//
//     _path = _getPath(s);
//     PathMetrics pms = _path.computeMetrics();
//     PathMetric pm = pms.elementAt(0);
//     double len = pm.length;
//
//     _animation = Tween(begin: 0.0, end: len).animate(_controller)
//       ..addListener(() {
//         setState(() {
//           _fraction = _animation.value;
//         });
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller.stop();
//         }
//       });
//
//     _controller.forward();
//   }
// }
//
// class PathPainter extends CustomPainter {
//   double _fraction;
//   Path _path;
//   List<Offset> _points = List<Offset>();
//
//   PathPainter(this._path, this._fraction);
//
//   Paint _paint = Paint()
//     ..color = Colors.blue
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 4.0;
//
//   Paint _paint2 = Paint()
//     ..color = Colors.red
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 4.0;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (_path == null) {
//       return;
//     }
//     PathMetrics pms = _path.computeMetrics();
//     PathMetric pm = pms.elementAt(0);
//     double len = pm.length;
//     double linelen = len / 20;
//
//     double tmpStart = _fraction;
//     double end = (_fraction + linelen) > len ? len : (_fraction + linelen);
//     if (end >= len) {
//       tmpStart = len - linelen;
//     }
//     for (; tmpStart < end; tmpStart++) {
//       Tangent? t = pm.getTangentForOffset(tmpStart);
//       _points.add(t!.position);
//     }
//
//     canvas.drawPath(_path, _paint);
//     canvas.drawPoints(PointMode.points, _points, _paint2);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
