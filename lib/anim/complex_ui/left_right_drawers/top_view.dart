import 'package:flutter/material.dart';

/// 上层视图
class TopView extends StatelessWidget {
  const TopView({
    Key? key,
    this.onLeading,
  }) : super(key: key);

  final VoidCallback? onLeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            this.onLeading?.call();
          },
        ),
        title: Text('Hello'),
        backgroundColor: Colors.white,
      ),
    );
  }
}
