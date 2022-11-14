import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wtoolset/anim/index.dart' as anim;
import 'package:wtoolset/draw/index.dart' as draw;
import 'package:wtoolset/overlay/toast/toast.dart';
import 'package:wtoolset/test/video_player_demo.dart';
import 'package:wtoolset/touch/index.dart' as touch;
import 'package:wtoolset/editController/index.dart' as controller;
import 'package:wtoolset/performance/index.dart' as performance;
import 'package:wtoolset/scroll/index.dart' as scroll;
import 'package:wtoolset/path/index.dart' as path;
import 'package:wtoolset/test/index.dart' as test;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewList = <Map<String, Object>>[
    {
      "title": "动画",
      "onTap": () {
        Get.to(() => const anim.HomePage());
      },
    },
    {
      "title": "绘制",
      "onTap": () {
        Get.to(() => const draw.HomePage());
      },
    },
    {
      "title": "点击",
      "onTap": () {
        Get.to(() => const touch.HomePage());
      },
    },
    {
      "title": "自定义控制器",
      "onTap": () {
        Get.to(() => const controller.HomePage());
      },
    },
    {
      "title": "性能测试",
      "onTap": () {
        Get.to(() => const performance.HomePage());
      },
    },
    {
      "title": "滑动",
      "onTap": () {
        Get.to(() => const scroll.HomePage());
      },
    },
    {
      "title": "path",
      "onTap": () {
        Get.to(() => const path.HomePage());
      },
    },
    {
      "title": "测试",
      "onTap": () {
        Get.to(() => const test.HomePage());
      },
    },
  ];

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
