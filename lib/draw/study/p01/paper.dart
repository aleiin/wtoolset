import 'package:flutter/material.dart';

class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PagerPainter(),
      ),
    );
  }
}

class PagerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    /// 创建画笔
    final Paint paint = Paint();

    paint
      ..color = Colors.blue //给画笔设置颜色
      ..strokeWidth = 5 //给画笔设置线宽
      ..style = PaintingStyle.stroke; //给画笔设置样式

    ///绘制圆
    // canvas.drawCircle(Offset(100, 100), 10, paint);

    /// 绘制线
    canvas.drawLine(Offset.zero, Offset(100, 100), paint);

    Path path = Path();
    path.moveTo(100, 100);
    path.lineTo(200, 0);

    canvas.drawPath(path, paint..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
