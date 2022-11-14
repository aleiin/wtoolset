import 'package:flutter/material.dart';

class SliverPinnedHeader extends StatelessWidget {
  const SliverPinnedHeader({
    Key? key,
    required this.child,
    this.color = Colors.white,
  }) : super(key: key);

  final PreferredSizeWidget child;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverPinnedHeaderDelegate(
        child: child,
        color: color,
      ),
    );
    ;
  }
}

class _SliverPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final Color color;

  _SliverPinnedHeaderDelegate({
    required this.child,
    required this.color,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: color,
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverPinnedHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.color != color;
  }
}
