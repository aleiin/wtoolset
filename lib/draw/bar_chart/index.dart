import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/bar_chart/bar_chart.dart';

class BarChartDemo extends StatefulWidget {
  const BarChartDemo({Key? key}) : super(key: key);

  @override
  State<BarChartDemo> createState() => _BarChartDemoState();
}

class _BarChartDemoState extends State<BarChartDemo> {
  /// 金额
  final chart = LineChartEntity(xData: [], yData: []);

  /// 订单金额点击坐标
  final ValueNotifier<Offset> tapOffset = ValueNotifier(Offset.zero);

  @override
  void initState() {
    super.initState();
    List.generate(5, (index) {
      chart.xData.add("第$index");
      chart.yData.add(Random().nextInt(10000).toDouble());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("自绘条形图"),
      ),
      body: LineChartsPage(
        data: chart,
        tapOffset: tapOffset,
        onTapOffsetCallBack: (Offset offset) {
          tapOffset.value = offset;
        },
      ),
    );
  }
}
