import 'dart:math';

import 'package:flutter/material.dart';

/// 特定角度扩散布局
class SpecificBurstFlow extends StatefulWidget {
  const SpecificBurstFlow({Key? key}) : super(key: key);

  @override
  State<SpecificBurstFlow> createState() => _SpecificBurstFlowState();
}

class _SpecificBurstFlowState extends State<SpecificBurstFlow>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController animationController;

  ///
  late Animation<double> repaint;

  ///
  int length = 5;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    repaint = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  ///
  void toggle() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  Widget _buildItem({double width = 40, int index = 0}) {
    return Container(
      width: width,
      height: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.primaries[index % length],
        // shape: BoxShape.circle,
      ),
      child: Text('$index'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('特定角度扩散flow布局'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: toggle,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Flow(
                  delegate: SpecificBurstFlowDelegate(repaint: repaint),
                  children: List.generate(length, (index) {
                    return _buildItem(index: index);
                  }),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.black,
          ),
          Container(
            width: 1,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class SpecificBurstFlowDelegate extends FlowDelegate {
  const SpecificBurstFlowDelegate({
    this.repaint,
  }) : super(repaint: repaint);

  ///
  // final Listenable? repaint;
  final Animation<double>? repaint;

  /// 用来画孩子的
  @override
  void paintChildren(FlowPaintingContext context) {
    print('print 11:21: cos(0): ${cos(0)}, sin(0): ${sin(0)}');

    ///
    Size size = context.size;

    /// 半径
    double radius = size.shortestSide / 2;

    /// 个数
    int count = context.childCount - 1;

    /// 特定角度
    double angle = 90;

    /// 度数
    double perRad = angle / 180 * pi / (count - 1);

    /// 修复偏移角度
    // double fixRotate = (angle / 2) / 180 * pi;
    double fixRotate = 0;

    for (int i = 0; i < count; i++) {
      double cSizeX = (context.getChildSize(i) ?? Size.zero).width / 2;
      double cSizeY = (context.getChildSize(i) ?? Size.zero).height / 2;

      var offsetX = (repaint?.value ?? 0.0) *
              (radius - cSizeX) *
              cos(i * perRad - fixRotate) +
          radius;

      var offsetY = (repaint?.value ?? 0.0) *
              (radius - cSizeY) *
              sin(i * perRad - fixRotate) +
          radius;

      Matrix4 m4 = Matrix4.translationValues(
        offsetX - cSizeX,
        offsetY - cSizeY,
        0.0,
      );

      context.paintChild(i + 1, transform: m4);
    }

    final Size menuSize = context.getChildSize(0) ?? Size.zero;

    context.paintChild(
      0,
      transform: Matrix4.translationValues(
        radius - menuSize.width / 2,
        radius - menuSize.height / 2,
        0.0,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant SpecificBurstFlowDelegate oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
