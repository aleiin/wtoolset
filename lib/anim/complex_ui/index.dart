import 'package:flutter/material.dart';

class ComplexUI extends StatefulWidget {
  const ComplexUI({super.key});

  @override
  State<ComplexUI> createState() => _ComplexUIState();
}

class _ComplexUIState extends State<ComplexUI>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double maxSlide = 200;

  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    Future.delayed(Duration.zero, () {
      maxSlide = MediaQuery.of(context).size.width / 1.5;
    });

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

  ///
  void onHorizontalDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < MediaQuery.of(context).size.width;

    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxSlide;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  ///
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
  }

  ///
  void onHorizontalDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQueryData.fromView(View.of(context)).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
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
        onHorizontalDragStart: onHorizontalDragStart,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragEnd: onHorizontalDragEnd,
        // onTap: toggle,
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
