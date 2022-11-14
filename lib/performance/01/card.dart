import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  const MyCard({
    this.height = 100.0,
    this.width,
    this.color = Colors.white,
    this.child,
    Key? key,
  }) : super(key: key);

  final double height;

  final double? width;

  final Color color;

  final Widget? child;

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width ?? MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(2),
      ),
      child: widget.child,
    );
  }
}
