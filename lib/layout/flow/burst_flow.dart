import 'dart:math';

import 'package:flutter/material.dart';

/// 扩散布局
class BurstFlow extends StatefulWidget {
  const BurstFlow({Key? key}) : super(key: key);

  @override
  State<BurstFlow> createState() => _BurstFlowState();
}

class _BurstFlowState extends State<BurstFlow>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController animationController;

  ///
  late Animation<double> repaint;

  ///
  int length = 6;

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

  Widget _buildItem({double width = 50, int index = 0}) {
    return Container(
      width: width,
      height: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.primaries[index % length],
        shape: BoxShape.circle,
      ),
      child: Text('$index'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('扩散flow布局'),
      ),
      body: InkWell(
        onTap: toggle,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.grey,
            alignment: Alignment.center,
            child: Flow(
              delegate: BurstFlowDelegate(repaint: repaint),
              children: List.generate(length, (index) {
                return _buildItem(index: index);
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class BurstFlowDelegate extends FlowDelegate {
  const BurstFlowDelegate({
    this.repaint,
  }) : super(repaint: repaint);

  ///
  // final Listenable? repaint;
  final Animation<double>? repaint;

  /// 用来画孩子的
  @override
  void paintChildren(FlowPaintingContext context) {
    ///
    Size size = context.size;

    /// 半径
    double radius = size.shortestSide / 2;

    /// 个数
    int count = context.childCount;

    /// 度数
    double perRad = 2 * pi / count;

    for (int i = 0; i < context.childCount; i++) {
      double cSizeX = (context.getChildSize(i) ?? Size.zero).width / 2;
      double cSizeY = (context.getChildSize(i) ?? Size.zero).height / 2;

      var offsetX =
          (repaint?.value ?? 0.0) * (radius - cSizeX) * cos(i * perRad) +
              radius;

      var offsetY =
          (repaint?.value ?? 0.0) * (radius - cSizeY) * sin(i * perRad) +
              radius;

      context.paintChild(
        i,
        transform:
            Matrix4.translationValues(offsetX - cSizeX, offsetY - cSizeY, 0.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant BurstFlowDelegate oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
