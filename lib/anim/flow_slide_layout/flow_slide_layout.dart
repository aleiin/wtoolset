import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wtoolset/utils/util/custom_image.dart';

/// Flow滑动布局
class FlowSlideLayout extends StatefulWidget {
  const FlowSlideLayout({Key? key}) : super(key: key);

  @override
  State<FlowSlideLayout> createState() => _FlowSlideLayoutState();
}

class _FlowSlideLayoutState extends State<FlowSlideLayout>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController _controller;

  ///
  final ValueNotifier<double> factor = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///
  Future<void> close() async {
    Animation<double> animation = Tween<double>(
            begin: factor.value, end: MediaQuery.of(context).size.width - 100)
        .animate(_controller);

    animation.addListener(() {
      factor.value = animation.value;
    });

    await _controller.forward(from: 0);
  }

  ///
  Future<void> open() async {
    Animation<double> animation =
        Tween<double>(begin: factor.value, end: 0).animate(_controller);

    animation.addListener(() {
      factor.value = animation.value;
    });

    await _controller.forward(from: 0);
  }

  ///
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    double cur = factor.value + details.delta.dx;
    factor.value = cur.clamp(0, MediaQuery.of(context).size.width);
  }

  ///
  void onHorizontalDragEnd(DragEndDetails details) {
    if (factor.value > MediaQuery.of(context).size.width / 2) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow滑动布局'),
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragEnd: onHorizontalDragEnd,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Flow(
            delegate: FlowSlideLayoutFlowDelegate(offsetX: factor),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.amber,
                child: CustomImage.network(CustomImage.imgUrl),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.deepPurpleAccent.withOpacity(0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(),
                    TextButton(
                      onPressed: close,
                      child: const Text(
                        '关闭',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: open,
                child: const Icon(
                  Icons.menu_open_outlined,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlowSlideLayoutFlowDelegate extends FlowDelegate {
  const FlowSlideLayoutFlowDelegate({required this.offsetX})
      : super(repaint: offsetX);

  ///
  final ValueListenable<double> offsetX;

  @override
  void paintChildren(FlowPaintingContext context) {
    Size size = context.size;
    context.paintChild(0);

    Matrix4 offsetM4 = Matrix4.translationValues(offsetX.value, 0, 0);
    context.paintChild(1, transform: offsetM4);

    /// 偏移量对于父级尺寸
    if (offsetX.value == size.width) {
      Matrix4 m1 = Matrix4.translationValues(
          size.width / 2 - 30, size.height / 2 - 30, 0);
      context.paintChild(2, transform: m1);

      Matrix4 m2 = Matrix4.translationValues(
          size.width / 2 - 30, -(size.height / 2 - 50), 0);
      context.paintChild(3, transform: m2);
    }
  }

  @override
  bool shouldRepaint(covariant FlowSlideLayoutFlowDelegate oldDelegate) {
    return oldDelegate.offsetX.value != offsetX.value;
  }
}
