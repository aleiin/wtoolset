import 'package:flutter/material.dart';
import 'package:wtoolset/home_item.dart';
import 'package:wtoolset/layout/flow/burst_flow.dart';
import 'package:wtoolset/layout/flow/circle_flow.dart';
import 'package:wtoolset/layout/flow/color_block_flow.dart';
import 'package:wtoolset/layout/flow/specific_burst_flow.dart';

import 'package:wtoolset/utils/route.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final List<Map<String, Object>> viewList = <Map<String, Object>>[];

  @override
  void initState() {
    super.initState();
    viewList.addAll(<Map<String, Object>>[
      {
        "title": "色块flow布局",
        "onTap": () {
          const Navigator().pushRoute(context, const ColorBlockFlow());
        },
      },
      {
        "title": "圆形flow布局",
        "onTap": () {
          const Navigator().pushRoute(context, const CircleFlow());
        },
      },
      {
        "title": "扩散flow布局",
        "onTap": () {
          const Navigator().pushRoute(context, const BurstFlow());
        },
      },
      {
        "title": "特定角度扩散flow布局",
        "onTap": () {
          const Navigator().pushRoute(context, const SpecificBurstFlow());
        },
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("布局"),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: ListView.builder(
          itemCount: viewList.length,
          itemBuilder: (BuildContext context, int index) {
            return HomeItem(
              text: viewList[index]['title'] as String,
              onCallBack: viewList[index]['onTap'] as Function(),
            );
          },
        ),
      ),
    );
  }
}
