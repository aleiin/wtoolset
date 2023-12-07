import 'package:flutter/material.dart';

/// 色块布局
class ColorBlockFlow extends StatefulWidget {
  const ColorBlockFlow({Key? key}) : super(key: key);

  @override
  State<ColorBlockFlow> createState() => _ColorBlockFlowState();
}

class _ColorBlockFlowState extends State<ColorBlockFlow> {
  ///
  final List<double> sides = [60.0, 50.0, 40.0, 30.0];

  ///
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
  ];

  Widget _buildItem(double e) {
    return Container(
      width: e,
      height: e,
      alignment: Alignment.center,
      color: colors[sides.indexOf(e)],
      child: Text('$e'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('色块flow布局'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Flow(
            delegate: ColorBlockFlowDelegate(),
            children: sides.map((e) => _buildItem(e)).toList(),
          ),
        ),
      ),
    );
  }
}

class ColorBlockFlowDelegate extends FlowDelegate {
  /// 用来画孩子的
  @override
  void paintChildren(FlowPaintingContext context) {
    var size = context.size;

    Matrix4 matrix4 = Matrix4.identity();

    for (int i = 0; i < context.childCount; i++) {
      var cSize = context.getChildSize(i) ?? Size.zero;

      if (i == 1) {
        matrix4 = Matrix4.translationValues(size.width - cSize.width, 0.0, 0.0);
      } else if (i == 2) {
        matrix4 = Matrix4.translationValues(0, size.height - cSize.height, 0);
      } else if (i == 3) {
        matrix4 = Matrix4.translationValues(
            size.width - cSize.width, size.height - cSize.height, 0);
      }

      context.paintChild(i, transform: matrix4);
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}
