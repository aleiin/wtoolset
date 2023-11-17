import 'package:flutter/material.dart';

import 'package:wtoolset/anim/index.dart' as anim;
import 'package:wtoolset/draw/index.dart' as draw;
import 'package:wtoolset/overlay/toast/toast.dart';
import 'package:wtoolset/touch/index.dart' as touch;
import 'package:wtoolset/editController/index.dart' as controller;
import 'package:wtoolset/performance/index.dart' as performance;
import 'package:wtoolset/scroll/index.dart' as scroll;
import 'package:wtoolset/path/index.dart' as path;
import 'package:wtoolset/test/index.dart' as test;
import 'package:wtoolset/utils/route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
        "title": "点击",
        "onTap": () {
          const Navigator().pushRoute(context, const touch.HomePage());
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
        "title": "path",
        "onTap": () {
          const Navigator().pushRoute(context, const path.HomePage());
        },
      },
      {
        "title": "测试",
        "onTap": () {
          const Navigator().pushRoute(context, const test.HomePage());
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
