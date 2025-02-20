import 'package:flutter/material.dart';

import 'package:wtoolset/anim/index.dart' as anim;
import 'package:wtoolset/draw/index.dart' as draw;
import 'package:wtoolset/home_item.dart';
import 'package:wtoolset/layout/layout.dart';
import 'package:wtoolset/overlay/toast/toast.dart';
import 'package:wtoolset/editController/index.dart' as controller;
import 'package:wtoolset/performance/index.dart' as performance;
import 'package:wtoolset/scroll/index.dart' as scroll;
import 'package:wtoolset/test/index.dart' as test;
import 'package:wtoolset/utils/route.dart';
import 'package:wtoolset/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///
  List<Map<String, Object>> viewList = <Map<String, Object>>[];

  @override
  void initState() {
    super.initState();

    viewList = <Map<String, Object>>[
      {
        "title": "动画",
        "onTap": () {
          const Navigator().pushRoute(context, const anim.HomePage());
        },
      },
      {
        "title": "绘制",
        "onTap": () {
          const Navigator().pushRoute(context, const draw.HomePage());
        },
      },
      {
        "title": "自定义控制器",
        "onTap": () {
          const Navigator().pushRoute(context, const controller.HomePage());
        },
      },
      {
        "title": "性能测试",
        "onTap": () {
          const Navigator().pushRoute(context, const performance.HomePage());
        },
      },
      {
        "title": "滑动",
        "onTap": () {
          const Navigator().pushRoute(context, const scroll.HomePage());
        },
      },
      {
        "title": "测试",
        "onTap": () {
          const Navigator().pushRoute(context, const test.HomePage());
        },
      },
      {
        "title": "布局",
        "onTap": () {
          const Navigator().pushRoute(context, const LayoutPage());
        },
      },
      {
        "title": "工具类",
        "onTap": () {
          const Navigator().pushRoute(context, const UtilPage());
        },
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("工具集"),
        actions: [
          InkWell(
            onTap: () {
              // Get.to(() => VideoApp());
              // Toast.show(context: context, message: "这是弹窗");
              Toast.showTopWidget(context: context, message: "这是弹窗是吗");
            },
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Icon(Icons.add),
            ),
          )
        ],
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
