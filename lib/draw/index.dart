import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtoolset/draw/bar_chart/index.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/coordinate_system_day_01.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewList = <Map<String, Object>>[
    {
      "title": "路径",
      "onTap": () {
        // Get.to(() => main05.MyApp());
      },
    },
    {
      "title": "可操作坐标系",
      "onTap": () {
        Get.to(() => const CoordinateSystemDay01());
      },
    },
    {
      "title": "自绘条形图",
      "onTap": () {
        Get.to(() => const BarChartDemo());
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("绘制集"),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: ListView.builder(
          itemCount: viewList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 48,
              margin: const EdgeInsets.only(
                top: 10,
                left: 12,
                right: 12,
              ),
              decoration: const BoxDecoration(
                // color: Colors.greenAccent,
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: InkWell(
                onTap: viewList[index]['onTap'] as Function(),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(viewList[index]['title'] as String),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
