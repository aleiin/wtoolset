import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations(// 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // // SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
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
      home: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("ListView滑动测试"),
        ),
        body: ListView(
          physics: const RangeMaintainingScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.deepOrange,
              margin: const EdgeInsets.only(top: 10),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.blue,
              margin: const EdgeInsets.only(top: 10),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.deepOrange,
              margin: const EdgeInsets.only(top: 10),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.blue,
              margin: const EdgeInsets.only(top: 10),
            ),
          ],
        ),
      ),
    );
  }
}
