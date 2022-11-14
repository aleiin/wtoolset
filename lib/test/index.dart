import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wtoolset/test/01/main.dart' as main01;
import 'package:wtoolset/test/02/main.dart' as main02;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewList = <Map<String, Object>>[
    {
      "title": "测试",
      "onTap": () {
        Get.to(() => main01.MyApp());
      },
    },
    {
      "title": "顶部下拉图片放大",
      "onTap": () {
        Get.to(() => main02.MyApp());
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("测试"),
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
