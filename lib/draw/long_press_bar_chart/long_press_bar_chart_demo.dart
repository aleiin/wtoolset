import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/long_press_bar_chart/long_press_bar_chart.dart';

class LongPressBarChartDemo extends StatefulWidget {
  const LongPressBarChartDemo({Key? key}) : super(key: key);

  @override
  State<LongPressBarChartDemo> createState() => _LongPressBarChartDemoState();
}

class _LongPressBarChartDemoState extends State<LongPressBarChartDemo> {
  /// 金额
  final LongPressBarChartEntity chart =
      LongPressBarChartEntity(xData: [], yData: []);

  /// 订单金额点击坐标
  final ValueNotifier<Offset> tapOffset = ValueNotifier(Offset.zero);

  ///
  final ValueNotifier<Offset>? longPressOffset = ValueNotifier(Offset.zero);

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
        title: const Text("长按条形图"),
      ),
      body: LongPressBarChart(
        data: chart,
        tapOffset: tapOffset,
        longPressOffset: longPressOffset,
        onTapOffsetCallBack: (Offset offset) {
          tapOffset.value = offset;
        },
      ),
    );
  }
}
