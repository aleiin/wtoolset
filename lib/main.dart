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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,

          /// 影响card的表色,因为m3下是applySurfaceTint, 在material中
          surfaceTint: Colors.transparent,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 24.0,
          ),
          backgroundColor: Colors.blue,
          titleTextStyle: Typography.dense2014.titleLarge,
        ),
      ),
      home: const HomePage(),
    );
  }
}

/// 小郭适配m3代码,留着备用
// return ThemeData(
// ///用来适配 Theme.of(context).primaryColorLight 和 primaryColorDark 的颜色变化，不设置可能会是默认蓝色
// primarySwatch: color as MaterialColor,
//
// /// Card 在 M3 下，会有 apply Overlay
//
// colorScheme: ColorScheme.fromSeed(
// seedColor: color,
// primary: color,
//
// brightness: Brightness.light,
//
// ///影响 card 的表色，因为 M3 下是  applySurfaceTint ，在 Material 里
// surfaceTint: Colors.transparent,
// ),
//
// /// 受到 iconThemeData.isConcrete 的印象，需要全参数才不会进入 fallback
// iconTheme: IconThemeData(
// size: 24.0,
// fill: 0.0,
// weight: 400.0,
// grade: 0.0,
// opticalSize: 48.0,
// color: Colors.white,
// opacity: 0.8,
// ),
//
// ///修改 FloatingActionButton的默认主题行为
// floatingActionButtonTheme: FloatingActionButtonThemeData(
// foregroundColor: Colors.white,
// backgroundColor: color,
// shape: CircleBorder()),
// appBarTheme: AppBarTheme(
// iconTheme: IconThemeData(
// color: Colors.white,
// size: 24.0,
// ),
// backgroundColor: color,
// titleTextStyle: Typography.dense2014.titleLarge,
// systemOverlayStyle: SystemUiOverlayStyle.light,
// ),
