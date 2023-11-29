import 'package:flutter/material.dart';
import 'package:wtoolset/draw/bar_chart/index.dart';
import 'package:wtoolset/draw/circular_progress/circular_progress.dart';
import 'package:wtoolset/draw/coordinate_system/day_01/coordinate_system_day_01.dart';
import 'package:wtoolset/draw/painter_badge/painter_badge.dart';
import 'package:wtoolset/utils/route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, Object>> viewList = <Map<String, Object>>[];

  @override
  void initState() {
    super.initState();
    viewList.addAll(<Map<String, Object>>[
      {
        "title": "可操作坐标系",
        "onTap": () {
          const Navigator().pushRoute(context, const CoordinateSystemDay01());
        },
      },
      {
        "title": "自绘条形图",
        "onTap": () {
          const Navigator().pushRoute(context, const BarChartDemo());
        },
      },
      {
        "title": "自绘角标",
        "onTap": () {
          const Navigator().pushRoute(context, const PainterBadge());
        },
      },
      {
        "title": "圆形进度条",
        "onTap": () {
          const Navigator().pushRoute(context, const CircularProgress());
        },
      },
    ]);
  }

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
