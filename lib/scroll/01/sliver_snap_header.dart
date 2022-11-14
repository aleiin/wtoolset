import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverSnapHeader extends StatefulWidget {
  const SliverSnapHeader({
    Key? key,
    required this.child,
  }) : super(key: key);

  final PreferredSizeWidget child;

  @override
  _SliverSnapHeaderState createState() => _SliverSnapHeaderState();
}

class _SliverSnapHeaderState extends State<SliverSnapHeader>
    with TickerProviderStateMixin {
  FloatingHeaderSnapConfiguration? _snapConfiguration;
  PersistentHeaderShowOnScreenConfiguration? _showOnScreenConfiguration;

  /// 初始化配置对象
  void _initSnapConfiguration() {
    _snapConfiguration = FloatingHeaderSnapConfiguration(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 200),
    );

    _showOnScreenConfiguration =
        const PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: double.infinity,
    );
  }

  @override
  void initState() {
    super.initState();
    _initSnapConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      pinned: false,
      delegate: _SliverSnapHeaderDelegate(
        vsync: this,
        child: widget.child,
        snapConfiguration: _snapConfiguration,
        showOnScreenConfiguration: _showOnScreenConfiguration,
      ),
    );
  }
}

class _SliverSnapHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;

  @override
  TickerProvider vsync;

  @override
  PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  @override
  FloatingHeaderSnapConfiguration? snapConfiguration;

  _SliverSnapHeaderDelegate({
    required this.child,
    required this.snapConfiguration,
    required this.vsync,
    required this.showOnScreenConfiguration,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverSnapHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.vsync != vsync ||
        oldDelegate.snapConfiguration != snapConfiguration ||
        oldDelegate.showOnScreenConfiguration != showOnScreenConfiguration;
  }
}
