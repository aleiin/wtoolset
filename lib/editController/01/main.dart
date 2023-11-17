import 'package:flutter/material.dart';
import 'package:wtoolset/editController/01/music_play.dart';

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
  final _playController = MusicPlayController(animating: true);

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
          title: const Text("音乐播放器-自定义控制器"),
        ),
        body: Center(
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  if (_playController.animating) {
                    _playController.stop();
                  } else {
                    _playController.play();
                  }
                  setState(() {});
                },
                child: Text(_playController.animating ? "停止" : "开始"),
              ),
              MusicPlay(
                controller: _playController,
                duration: const Duration(seconds: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
