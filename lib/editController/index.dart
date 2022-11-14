import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wtoolset/editController/01/main.dart' as main01;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewList = <Map<String, Object>>[
    {
      "title": "音乐播放器-自定义控制器",
      "onTap": () {
        Get.to(() => main01.MyApp());
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("编写控制器"),
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
