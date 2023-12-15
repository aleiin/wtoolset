import 'package:flutter/material.dart';
import 'package:wtoolset/layout/expand_collapse/expand_collapse.dart';

class ExpandCollapseDemo extends StatelessWidget {
  const ExpandCollapseDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('展开和收缩组件'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            ExpandCollapse(
              child: Text('这是规则' * 100),
            ),
          ],
        ),
      ),
    );
  }
}
