import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtoolset/draw/p04/paper.dart';

void main() {
  ///确定初始化
  WidgetsFlutterBinding.ensureInitialized();

  /// 使设备横屏显示
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  );

  ///全屏显示
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}
