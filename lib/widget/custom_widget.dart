import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtoolset/widget/custom_app_bar.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({
    super.key,
    this.isCustomAppBar = true,
    this.appBar,
    this.leading,
    this.title,
    this.appBarBackgroundColor,
    this.scaffoldBackgroundColor,
    this.iconTheme,
    this.elevation = 0,
    this.titleLabel = '标题',
    this.titleLabelOnTap,
    this.titleLabelStyle,
    this.automaticallyImplyLeading = true,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
    this.body,
    this.actions,
    this.endDrawer,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.systemOverlayStyle,
    this.centerTitle = true,
    this.floatingActionButton,
  });

  /// 是否使用自定义的appBar
  final bool isCustomAppBar;

  ///
  final PreferredSizeWidget? appBar;

  ///
  final Widget? leading;

  ///
  final Widget? title;

  ///
  final Color? appBarBackgroundColor;

  ///
  final Color? scaffoldBackgroundColor;

  ///
  final IconThemeData? iconTheme;

  ///
  final double? elevation;

  ///
  final String titleLabel;

  final Function()? titleLabelOnTap;

  ///
  final TextStyle? titleLabelStyle;

  ///
  final bool automaticallyImplyLeading;

  ///
  final bool extendBodyBehindAppBar;

  final bool extendBody;

  ///
  final Widget? body;

  ///
  final List<Widget>? actions;

  ///
  final Widget? endDrawer;

  ///
  final Widget? bottomNavigationBar;

  ///
  final bool resizeToAvoidBottomInset;

  ///
  final SystemUiOverlayStyle? systemOverlayStyle;

  ///
  final bool centerTitle;

  final Widget? floatingActionButton;

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isCustomAppBar
          ? AppBar(
              leading: widget.leading,
              title: GestureDetector(
                onTap: widget.titleLabelOnTap,
                child: widget.title ??
                    Text(
                      widget.titleLabel,
                      style: widget.titleLabelStyle,
                    ),
              ),
              automaticallyImplyLeading: widget.automaticallyImplyLeading,
              actions: widget.actions,
              backgroundColor: widget.appBarBackgroundColor,
              iconTheme: widget.iconTheme,
              elevation: widget.elevation,
              // systemOverlayStyle:
              //     widget.systemOverlayStyle ?? SystemUiOverlayStyle.dark,
              centerTitle: widget.centerTitle,
            )
          : widget.appBar,
      body: widget.body,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      endDrawer: widget.endDrawer,
      bottomNavigationBar: widget.bottomNavigationBar,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      backgroundColor: widget.scaffoldBackgroundColor,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
