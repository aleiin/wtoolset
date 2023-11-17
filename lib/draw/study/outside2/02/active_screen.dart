import 'dart:math';


import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/outside2/02/data_modle.dart';
import 'package:wtoolset/draw/study/outside2/02/xian.dart';

class ActiveScreen extends StatefulWidget {
  static String routeName = 'activeName';

  @override
  _ActiveScreenState createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen>
    with TickerProviderStateMixin {
  var p0;

  var p1;

  var p2;

  late DataModle dataModle;

  late AnimationController animationController;

  late Animation animation;

  @override
  void initState() {
    // 开始点

    p0 = const Offset(100, 100);

    // 控制点

    p1 = const Offset(100, 500);

    //结束点

    p2 = const Offset(300, 300);

    dataModle = DataModle();

    // 定义动画控制器

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    // 定义动画

    animation =

        // Tween(begin: Offset(100, 100), end: Offset(100, 201))

        Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.linear))
            .animate(animationController);

    animation.addListener(() {
      updateOffset();
    });

    updateOffset();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                animationController.reset();

                animationController.forward();
              })
        ],
      ),
      body: Stack(
        children: [
          Transform(
            origin: const Offset(25, 25), // 手动调整，适合内容不是正方形的场景

            // alignment: Alignment.center, // 自动居中，内容是正方形的时候可以用这个

            transform: Matrix4.identity()
              ..translate(dataModle.left, dataModle.top, 0.0)
              ..rotateZ(dataModle.rotate),

            child: const SizedBox(
              height: 50,
              width: 50,
              // color: Colors.red,
              child: Icon(
                Icons.send,
              ),
            ),
          ),
          CustomPaint(
            painter: Xian(p0: p0, p1: p1, p2: p2),
          ),
        ],
      ),
    );
  }

  updateOffset() {
    // 获取动画的当前值

    var t = animation.value;

    // 得到组件当前的位置

    Offset currentOffset = Offset(dataModle.left, dataModle.top);

    // 计算并重新赋值

    dataModle.left =
        (pow(1 - t, 2) * p0.dx + 2 * t * (1 - t) * p1.dx + pow(t, 2) * p2.dx) -
            25.toDouble();

    dataModle.top =
        (pow(1 - t, 2) * p0.dy + 2 * t * (1 - t) * p1.dy + pow(t, 2) * p2.dy) -
            25.toDouble();

    // 求出旋转弧度 下一个点对于现在这个点的弧度是多少？

    double rorate = atan2(
        dataModle.top - currentOffset.dy, dataModle.left - currentOffset.dx);

    // double huDu = atan2(

    //    currentOffset.dy - dataModle.top, currentOffset.dx - dataModle.left);

    double angle = rorate / pi * 180;

    print("角度====$angle  弧度====$rorate");

    if (rorate != 0.0) {
      dataModle.rotate = rorate;
    }

    setState(() {});
  }
}
