import 'package:flutter/material.dart';
import 'package:flutter_ume_kit_console_plus/flutter_ume_kit_console_plus.dart';
import 'package:flutter_ume_kit_perf_plus/flutter_ume_kit_perf_plus.dart';
import 'package:flutter_ume_kit_ui_plus/flutter_ume_kit_ui_plus.dart';
import 'package:flutter_ume_plus/flutter_ume_plus.dart';

import 'home.dart';

void main() {
  // debugProfileBuildsEnabled = true;
  // debugProfilePaintsEnabled = true;
  // debugPaintLayerBordersEnabled = true;
  // runApp(const MyApp());

  PluginManager.instance // 注册插件
    ..register(const WidgetInfoInspector())
    ..register(const WidgetDetailInspector())
    ..register(const ColorSucker())
    ..register(AlignRuler())
    ..register(const ColorPicker()) // 新插件
    ..register(const TouchIndicator()) // 新插件
    ..register(Performance())
    // ..register(ShowCode())
    ..register(const MemoryInfoPage())
    // ..register(CpuInfoPage())
    // ..register(DeviceInfoPanel())
    ..register(Console());
  // ..register(DioInspector(dio: dio));

  runApp(const UMEWidget(child: MyApp(), enable: true));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
