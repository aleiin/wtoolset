import 'package:flutter/material.dart';
import 'package:wtoolset/anim/complex_ui/imitate_ku_gou/imitate_ku_gou.dart';
import 'package:wtoolset/anim/complex_ui/index.dart';
import 'package:wtoolset/anim/complex_ui/left_right_drawers/left_right_drawers.dart';
import 'package:wtoolset/anim/complex_ui/rotation_3d/rotation_3d.dart';
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
        "title": "简版左右抽屉视觉差",
        "onTap": () {
          const Navigator().pushRoute(context, const ComplexUI());
          // Get.to(() => main05.MyApp());
        },
      },
      {
        "title": "左右抽屉视觉差",
        "onTap": () {
          const Navigator().pushRoute(context, const LeftRightDrawers());
          // Get.to(() => main05.MyApp());
        },
      },
      {
        "title": "模仿酷狗",
        "onTap": () {
          const Navigator().pushRoute(context, const ImitateKuGou());
          // Get.to(() => main05.MyApp());
        },
      },
      {
        "title": "3d旋转",
        "onTap": () {
          const Navigator().pushRoute(context, const Rotation3d());
          // Get.to(() => main05.MyApp());
        },
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("动画集"),
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
