import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/p10/pic_man.dart';
import 'package:wtoolset/draw/study/p12/handle_widget.dart';

void main() => runApp(Paper());

/// create by 韦斌 on 2021/7/27 22:43
/// 说明: 手势
class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  double _rotate = 0;

  void onMove(double rotate, double distance) {
    _rotate = -rotate;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GestureDetector"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: _rotate,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ),
            Center(
              child: HandleWidget(
                onMove: onMove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
