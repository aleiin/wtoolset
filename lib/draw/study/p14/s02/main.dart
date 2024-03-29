import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtoolset/draw/study/p14/s02/paper.dart';

void main() {
  ///确定初始化
  WidgetsFlutterBinding.ensureInitialized();

  /// 使设备横屏显示
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );

  ///全屏显示
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(const Paper());
}
