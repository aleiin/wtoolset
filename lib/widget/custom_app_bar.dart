import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.titleLabel = '标题',
    this.titleLabelStyle,
    this.isShowHint = false,
    this.automaticallyImplyLeading = true,
    this.actions,
  }) : super(key: key);

  ///
  final Widget? title;

  ///
  final String titleLabel;

  ///
  final TextStyle? titleLabelStyle;

  ///
  final bool isShowHint;

  ///
  ///
  final bool automaticallyImplyLeading;

  ///
  final List<Widget>? actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (isShowHint ? 28 : 0));
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
        Visibility(
          visible: widget.isShowHint,
          child: Container(
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
        ),
        AppBar(
          title: widget.title ??
              Text(
                widget.titleLabel,
                style: widget.titleLabelStyle,
              ),
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          primary: false,
          actions: widget.actions,
        ),
      ],
    );
  }
}
