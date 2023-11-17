import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/p17/s01/paper.dart';

void main() {
  // ///确定初始化
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // /// 使设备横屏显示
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  // );
  //
  // ///全屏显示
  // // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Paper(),
    );
  }
}
