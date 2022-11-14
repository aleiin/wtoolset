import 'package:flutter/material.dart';
import 'package:wtoolset/draw/p10/pic_man.dart';

void main() => runApp(Paper());

/// create by 韦斌 on 2021/7/26 22:22
/// 说明: 动画
class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("animation"),
        ),
        body: Center(
          child: PicMan(),
        ),
      ),
    );
  }
}
