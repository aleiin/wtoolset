import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtoolset/draw/study/p05/paper.dart';

void main() {
  ///确定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // /// 使设备横屏显示
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  // );

  ///全屏显示
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("路径"),
        ),
        body: Paper(),
      ),
    );
  }
}
