import 'package:flutter/material.dart';

import 'package:wtoolset/scroll/01/main.dart' as main01;
import 'package:wtoolset/scroll/draggable_scrollable_sheet_demo/draggable_scrollable_sheet_demo.dart';
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
        "title": "仿掘金首页",
        "onTap": () {
          const Navigator().pushRoute(context, main01.MyApp());
        },
      },
      {
        "title": "DraggableScrollableSheetDemo",
        "onTap": () {
          const Navigator().pushRoute(context, DraggableScrollableSheetDemo());
        },
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("滑动"),
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
