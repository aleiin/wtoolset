import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wtoolset/anim/complex_ui/draggable_scrollable_sheet_list/expanded_event_item.dart';

const double minHeight = 120;
const double iconStartSize = 44;
const double iconEndSize = 120;
const double iconStartMarginTop = 36;
const double iconEndMarginTop = 80;
const double iconsVerticalSpacing = 24;
const double iconsHorizontalSpacing = 16;

class ExhibitionBottomSheet extends StatefulWidget {
  const ExhibitionBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ExhibitionBottomSheet> createState() => _ExhibitionBottomSheetState();
}

class _ExhibitionBottomSheetState extends State<ExhibitionBottomSheet>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController animationController;

  ///
  double get maxHeight => MediaQuery.of(context).size.height * 0.8;

  ///
  double get headerTopMargin =>
      lerp(20, 20 + MediaQuery.of(context).padding.top);

  ///
  double get headerFontSize => lerp(14, 24);

  ///
  double get itemBorderRadius => lerp(8, 24);

  ///
  double get iconSize => lerp(iconStartSize, iconEndSize);

  ///
  double iconTopMargin(int index) =>
      lerp(iconStartMarginTop,
          iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize)) +
      headerTopMargin;

  ///
  double iconLeftMargin(int index) =>
      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // animationController.addListener(() {
    //   print('print 11:26: ${animationController.value}');
    // });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  ///
  double lerp(double min, double max) {
    // return Tween<double>(begin: min, end: max)
    //     .animate(animationController)
    //     .value;

    return lerpDouble(min, max, animationController.value) ?? 0.0;
  }

  ///
  void _toggle() {
    final bool isOpen = animationController.status == AnimationStatus.completed;

    animationController.fling(velocity: isOpen ? -2 : 2);
  }

  ///
  void onVerticalDragUpdate(DragUpdateDetails details) {
    animationController.value -= details.primaryDelta! / maxHeight;
  }

  ///
  void onVerticalDragEnd(DragEndDetails details) {
    if (animationController.isAnimating ||
        animationController.status == AnimationStatus.completed) {
      return;
    }

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;

    if (flingVelocity < 0.0) {
      animationController.fling(velocity: max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      animationController.fling(velocity: min(-2.0, -flingVelocity));
    } else {
      animationController.fling(
          velocity: animationController.value < 0.5 ? -2.0 : 2.0);
    }
  }

  Widget iconView(Event event) {
    int index = events.indexOf(event);

    return Positioned(
      height: iconSize,
      width: iconSize,
      top: iconTopMargin(index),
      left: iconLeftMargin(index),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(itemBorderRadius),
          right: Radius.circular(itemBorderRadius),
        ),
        child: Container(
          color: Colors.primaries[index % 3],
        ),
        // child: Image.asset(
        //   'asset/${event.assetName}',
        //   fit: BoxFit.cover,
        //   alignment: Alignment(lerp(1, 0) ?? 0, 0),
        // ),
      ),
    );
  }

  Widget fullItem(Event event) {
    int index = events.indexOf(event);

    return ExpandedEventItem(
      topMargin: iconTopMargin(index),
      leftMargin: iconLeftMargin(index),
      height: iconSize,
      isVisible: animationController.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      title: event.title,
      date: event.date,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: _toggle,
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: minHeight,
              color: Colors.orange,
            ),
            // child: Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 32),
            //   decoration: const BoxDecoration(
            //     color: Colors.orange,
            //     borderRadius: BorderRadius.vertical(
            //       top: Radius.circular(32),
            //     ),
            //   ),
            //   child: Stack(
            //     children: [
            //       const MenuButton(),
            //       SheetHeader(
            //         fontSize: headerFontSize,
            //         topMargin: headerTopMargin,
            //       ),
            //       for (Event event in events) fullItem(event),
            //       for (Event event in events) iconView(event),
            //     ],
            //   ),
            // ),
          ),
        );
      },
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      right: 0,
      bottom: 24,
      child: Icon(
        Icons.menu,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  const SheetHeader({
    Key? key,
    this.fontSize = 12,
    this.topMargin = 0,
  }) : super(key: key);

  ///
  final double fontSize;

  ///
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      child: Text(
        'Booked Exhibition',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

final List<Event> events = [
  Event(
    assetName: 'steve-johnson.jpeg',
    title: 'Shenzhen GLOBAL DESIGN AWARD 2018',
    date: '4.20-30',
  ),
  Event(
    assetName: 'efe-kurnaz.jpg',
    title: 'Shenzhen GLOBAL DESIGN AWARD 2018',
    date: '4.20-30',
  ),
  Event(
    assetName: 'rodion-kutsaev.jpeg',
    title: 'Dawan District Guangdong Hong Kong',
    date: '4.28-31',
  ),
];

class Event {
  const Event({
    this.assetName = '',
    this.title = '',
    this.date = '',
  });

  final String assetName;
  final String title;
  final String date;
}
