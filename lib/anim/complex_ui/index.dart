import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wtoolset/common.dart';
import 'package:wtoolset/draw/bar_chart/bar_chart.dart';

class ComplexUI extends StatefulWidget {
  const ComplexUI({Key? key}) : super(key: key);

  @override
  State<ComplexUI> createState() => _ComplexUIState();
}

class _ComplexUIState extends State<ComplexUI>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final double maxSlide = 225.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ///
  void toggle() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var myDrawer = Container(
      color: Colors.blue,
    );

    var myChild = Container(
      color: Colors.yellow,
    );

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.menu),
      //   ),
      //   title: const Text("复杂UI"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         _animationController.reset();
      //         _animationController.forward();
      //       },
      //       icon: const Icon(Icons.restart_alt),
      //     )
      //   ],
      // ),
      body: GestureDetector(
        onTap: toggle,
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              double slide = maxSlide * _animationController.value;
              double scale = 1 - (_animationController.value * 0.3);

              return Stack(
                children: [
                  myDrawer,
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: myChild,
                  ),
                ],
              );
            }),
      ),

      // body: AnimatedBuilder(
      //   animation: _animationController,
      //   child: Center(
      //     child: Container(
      //       width: 100,
      //       height: 100,
      //       color: Colors.orange,
      //     ),
      //   ),
      //   builder: (context, child) {
      //     return Transform.rotate(
      //       angle: _animationController.value * pi,
      //       child: child,
      //     );
      //   },
      // ),
    );
  }
}
