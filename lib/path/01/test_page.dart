import 'package:flutter/material.dart';

/// create by 韦斌 on 2021/9/30 16:18
/// 说明: 试验性界面
class BusinessTestPage extends StatefulWidget {
  /// 构造函数
  const BusinessTestPage({
    this.appBar,
    Key? key,
  }) : super(key: key);

  ///
  final Widget? appBar;

  @override
  _BusinessTestPageState createState() => _BusinessTestPageState();
}

class _BusinessTestPageState extends State<BusinessTestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      padding: const EdgeInsets.all(10),
      child: ClipPath(
        clipper: Clipper(),
        child: Container(
          color: Colors.orange.withOpacity(0.9),
          width: 300,
          height: 100,
          child: widget.appBar,
        ),
      ),
    );
  }
}

///
class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.lineTo(0, 0);
    // path.lineTo(0, size.height - 50);
    // var firstControlPoint = Offset(size.width / 2, size.height);
    // var firstEndPoint = Offset(size.width, size.height - 100);
    //
    // path.quadraticBezierTo(
    //   firstControlPoint.dx,
    //   firstControlPoint.dy,
    //   firstEndPoint.dx,
    //   firstEndPoint.dy,
    // );
    // path.lineTo(size.width, size.height - 50);
    // path.lineTo(size.width, 0);
    // path.close();
    // return path;

    const d = 5;

    const add = 5;

    /// 平均值
    final p = size.height / 18;

    final special = p * 4 + add * 4;

    final aa = size.height - special;

    final average = size.height / 18;

    var zero = Offset(size.width - d * 2, size.height);

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(zero.dx, zero.dy);

    // path.lineTo(size.width, size.height - average);

    ///////////////

    var v1 = Offset(size.width + d, size.height - 1 * average);

    var v2 = Offset(size.width - d, size.height - 2 * average);

    var v3 = Offset(size.width - d * 3, size.height - 3 * average);

    var v4 = Offset(size.width - d, size.height - 4 * average);

    ////////////

    var v5 = Offset(size.width + d, size.height - 5 * average);

    var v6 = Offset(size.width - d, size.height - 6 * average);

    var v7 = Offset(size.width - d * 3, size.height - 7 * average);

    var v8 = Offset(size.width - d, size.height - 8 * average);

    ///////////////

    var v9 = Offset(size.width + d, size.height - 9 * average);

    var v10 = Offset(size.width - d, size.height - 10 * average);

    var v11 = Offset(size.width - d * 3, size.height - 11 * average);

    var v12 = Offset(size.width - d, size.height - 12 * average);

    ////////////////////

    var v13 = Offset(size.width + d, size.height - 13 * average);

    var v14 = Offset(size.width - d, size.height - 14 * average);

    var v15 = Offset(size.width - d * 3, size.height - 15 * average);

    var v16 = Offset(size.width - d, size.height - 16 * average);

    //////////////

    var v17 = Offset(size.width + d, size.height - 17 * average);

    var v18 = Offset(size.width - d * 2, size.height - 18 * average);

    /////////////

    path.quadraticBezierTo(v1.dx, v1.dy, v2.dx, v2.dy);

    path.quadraticBezierTo(v3.dx, v3.dy, v4.dx, v4.dy);

    path.quadraticBezierTo(v5.dx, v5.dy, v6.dx, v6.dy);

    path.quadraticBezierTo(v7.dx, v7.dy, v8.dx, v8.dy);

    path.quadraticBezierTo(v9.dx, v9.dy, v10.dx, v10.dy);

    path.quadraticBezierTo(v11.dx, v11.dy, v12.dx, v12.dy);

    path.quadraticBezierTo(v13.dx, v13.dy, v14.dx, v14.dy);

    path.quadraticBezierTo(v15.dx, v15.dy, v16.dx, v16.dy);

    path.quadraticBezierTo(v17.dx, v17.dy, v18.dx, v18.dy);

    for (int i = 1; i <= 18; i++) {
      print('print 00:59: $i');
    }

    // //波浪曲线路径
    // path.lineTo(0, 0); //第1个点
    // path.lineTo(0, size.height - 40.0); //第2个点
    //
    // var firstControlPoint = Offset(size.width / 4, size.height); //第一段曲线控制点
    // var firstEndPoint = Offset(size.width / 2.25, size.height - 30); //第一段曲线结束点
    // path.quadraticBezierTo(
    //   //形成曲线
    //   firstControlPoint.dx,
    //   firstControlPoint.dy,
    //   firstEndPoint.dx,
    //   firstEndPoint.dy,
    // );
    //
    // var secondControlPoint =
    //     Offset(size.width / 4 * 3, size.height - 90); //第二段曲线控制点
    // var secondEndPoint = Offset(size.width, size.height - 40); //第二段曲线结束点
    // path.quadraticBezierTo(
    //     //形成曲线
    //     secondControlPoint.dx,
    //     secondControlPoint.dy,
    //     secondEndPoint.dx,
    //     secondEndPoint.dy);
    //
    // path.lineTo(size.width, size.height - 40);
    // path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
