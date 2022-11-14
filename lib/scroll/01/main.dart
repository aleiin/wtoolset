import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtoolset/draw/p18/01/world.dart';
import 'package:wtoolset/editController/01/music_play.dart';
import 'package:wtoolset/editController/01/music_play_controller.dart';
import 'package:wtoolset/scroll/01/ceiling.dart';
import 'package:wtoolset/scroll/01/nest_demo.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations(// 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Scaffold(
      //   // backgroundColor: Colors.black,
      //   appBar: AppBar(
      //     title: const Text("仿掘金首页"),
      //   ),
      //   body: const Ceiling(),
      // ),
      home: const NestDemo(),
    );
  }
}
