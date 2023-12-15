import 'package:flutter/material.dart';

/// 无网络布局
class NoNetwork extends StatelessWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.greenAccent,
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.titleLabel = '标题',
  }) : super(key: key);

  ///
  final String titleLabel;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 28);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).viewPadding.top,
          color: AppBarTheme.of(context).backgroundColor,
        ),
        Container(
          height: 28,
          color: Colors.red,
          // color: AppBarTheme.of(context).backgroundColor,
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.signal_cellular_alt),
              Text('網絡連接受限或不可用'),
            ],
          ),
        ),
        AppBar(
          title: Container(
            color: Colors.red,
            child: Text(widget.titleLabel ?? '无网络布局'),
          ),
          primary: false,
        ),
      ],
    );
  }
}
