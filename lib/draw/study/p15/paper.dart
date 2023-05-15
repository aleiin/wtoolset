import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/common/coordinate.dart';

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(
          repaint: _animationController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PaperPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();

  double waveWidth = 80; //波宽

  double wrapHeight = 100; //包裹高度

  double waveHeight = 10; //波高

  late final Animation<double>? repaint;

  PaperPainter({this.repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    // coordinate.paint(canvas, size);

    canvas.translate(size.width / 2, size.height / 2);

    /// 正方形
    // canvas.clipRect(Rect.fromCenter(
    //     center: Offset(waveWidth, 0), width: waveWidth * 2, height: 200));

    /// 圆
    canvas.clipPath(Path()
      ..addOval(Rect.fromCenter(
          center: Offset(waveWidth, 0),
          width: waveWidth * 2,
          height: waveWidth * 2)));
    //
    // /// 椭圆
    // canvas.clipPath(Path()
    //   ..addOval(Rect.fromCenter(
    //       center: Offset(waveWidth, 0), width: waveWidth * 2, height: 200)));

    // /// 圆角矩形
    // canvas.clipPath(
    //   Path()
    //     ..addRRect(
    //       RRect.fromRectXY(
    //         Rect.fromCenter(
    //             center: Offset(waveWidth, 0),
    //             width: waveWidth * 2,
    //             height: 200),
    //         30,
    //         30,
    //       ),
    //     ),
    // );

    Path path = getWavePath();

    Paint paint = Paint();

    canvas.save();
    canvas.translate(-waveWidth * 4 + 2 * waveWidth * repaint!.value, 0);

    canvas.drawPath(path, paint..color = Colors.orange);

    canvas.translate(2 * waveWidth * repaint!.value, 0);

    canvas.drawPath(path, paint..color = Colors.orange.withAlpha(88));

    canvas.restore();

    // canvas.drawRect(
    //   Rect.fromLTWH(0, -wrapHeight, waveWidth * 2, 200),
    //   Paint()
    //     ..style = PaintingStyle.stroke
    //     ..color = Colors.purple
    //     ..strokeWidth = 3,
    // );
  }

  Path getWavePath() {
    Path path = Path();
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      -waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      -waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      -waveHeight * 2,
      waveWidth,
      0,
    );
    path.relativeQuadraticBezierTo(
      waveWidth / 2,
      waveHeight * 2,
      waveWidth,
      0,
    );

    path.relativeLineTo(0, wrapHeight);

    path.relativeLineTo(-waveWidth * 3 * 2.0, 0);

    return path;
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
