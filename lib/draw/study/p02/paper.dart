import 'package:flutter/material.dart';

class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // 创建画笔
    Paint paint = Paint();
    Path path = Path();

    // canvas.drawCircle(
    //   Offset(180, 180), //坐标
    //   80, //半径
    //   paint
    //     ..strokeWidth = 5 //设置线宽
    //     ..color = Colors.blue
    //     ..style, //设置颜色
    // );

    // canvas.drawCircle(
    //   Offset(180 + 360, 180), //坐标
    //   80, // 半径
    //   paint
    //     ..color = Colors.red // 给画笔设置颜色
    //     ..isAntiAlias = false, // 给画笔设置抗锯齿
    // );

    // canvas.drawCircle(
    //   Offset(100, 100), // 设置坐标
    //   50, // 圆的半径
    //   paint
    //     ..style = PaintingStyle.stroke //给画笔设置线宽类型
    //     ..strokeWidth = 50 //线宽
    //     ..color = Colors.blue, //给画笔设置颜色
    // );
    //
    // canvas.drawCircle(
    //   Offset(300, 100), // 坐标
    //   50, // 圆的半径
    //   paint
    //     ..color = Colors.red //给画笔设置颜色
    //     ..strokeWidth = 50 // 给画笔设置线宽
    //     ..style = PaintingStyle.fill, // 给画笔设置的类型是填充
    // );

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;

    // canvas.drawLine(
    //   Offset(50, 50), // 起点
    //   Offset(50, 150), //终点
    //   paint..strokeCap = StrokeCap.butt, //线冒是不出头
    // );
    // canvas.drawLine(
    //   Offset(100, 50), // 起点
    //   Offset(100, 150), //终点
    //   paint..strokeCap = StrokeCap.round, //线冒是圆头
    // );
    // canvas.drawLine(
    //   Offset(150, 50), // 起点
    //   Offset(150, 150), //终点
    //   paint..strokeCap = StrokeCap.square, //线冒是方头
    // );

    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(
      path,
      paint..strokeJoin = StrokeJoin.bevel, //给画笔设置线接类型是斜角
    );

    path.reset();
    path.moveTo(50 + 150, 50);
    path.lineTo(50 + 150, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(
      path,
      paint..strokeJoin = StrokeJoin.miter, //给画笔设置线接类型是锐角
    );

    path.reset();
    path.moveTo(50 + 150 * 2, 50);
    path.lineTo(50 + 150 * 2, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(
      path,
      paint..strokeJoin = StrokeJoin.round, // 给画笔设置线接类型是圆角
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
