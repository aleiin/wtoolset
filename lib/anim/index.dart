import 'package:flutter/material.dart';
import 'package:wtoolset/anim/complex_ui/draggable_scrollable_sheet_list/draggable_scrollable_sheet_list.dart';
import 'package:wtoolset/anim/complex_ui/imitate_ku_gou/imitate_ku_gou.dart';
import 'package:wtoolset/anim/complex_ui/index.dart';
import 'package:wtoolset/anim/complex_ui/left_right_drawers/left_right_drawers.dart';
import 'package:wtoolset/anim/complex_ui/rotation_3d/rotation_3d.dart';
import 'package:wtoolset/anim/flow_slide_layout/flow_slide_layout.dart';
import 'package:wtoolset/home_item.dart';
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
      {
        "title": "拖拽列表",
        "onTap": () {
          const Navigator()
              .pushRoute(context, const DraggableScrollableSheetList());
          // Get.to(() => main05.MyApp());
        },
      },
      {
        "title": "Flow滑动布局",
        "onTap": () {
          const Navigator().pushRoute(context, const FlowSlideLayout());
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
