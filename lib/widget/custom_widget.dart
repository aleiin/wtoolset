import 'package:flutter/material.dart';
import 'package:wtoolset/widget/custom_app_bar.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({
    Key? key,
    this.isCustomAppBar = true,
    this.appBar,
    this.title,
    this.titleLabel = '标题',
    this.titleLabelStyle,
    this.automaticallyImplyLeading = true,
    this.body,
    this.actions,
    this.endDrawer,
  }) : super(key: key);

  /// 是否使用自定义的appBar
  final bool isCustomAppBar;

  ///
  final PreferredSizeWidget? appBar;

  ///
  final Widget? title;

  ///
  final String titleLabel;

  ///
  final TextStyle? titleLabelStyle;

  ///
  final bool automaticallyImplyLeading;

  ///
  final Widget? body;

  ///
  final List<Widget>? actions;

  ///
  final Widget? endDrawer;

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isCustomAppBar
          ? CustomAppBar(
              title: widget.title,
              titleLabel: widget.titleLabel,
              titleLabelStyle: widget.titleLabelStyle,
              automaticallyImplyLeading: widget.automaticallyImplyLeading,
              actions: widget.actions,
            )
          : widget.appBar,
      body: widget.body,
      endDrawer: widget.endDrawer,
    );
  }
}
