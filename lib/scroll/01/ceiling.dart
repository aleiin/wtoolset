import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wtoolset/common.dart';
import 'package:wtoolset/scroll/01/item_box.dart';

class Ceiling extends StatefulWidget {
  const Ceiling({Key? key}) : super(key: key);

  @override
  _CeilingState createState() => _CeilingState();
}

class _CeilingState extends State<Ceiling> {
  Widget _buildBox() {
    // return SliverToBoxAdapter(
    //   child: Container(
    //     height: 60,
    //     color: Colors.amber,
    //   ),
    // );
    return SliverPersistentHeader(
      floating: true,
      delegate: ShowOnScreenSPHD(height: 60),
    );
  }

  Widget _buildStickBox() {
    return SliverPersistentHeader(
      pinned: true, // 吸顶属性
      // delegate: FixedPersistentHeaderDelegate(height: 54),
      delegate: FlexibleSPHD(
        minHeight: 50,
        maxHeight: 150,
      ),
    );
  }

  Widget _buildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              index.toString(),
            ),
          );
        },
        childCount: 8,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
        mainAxisSpacing: 8,
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ItemBox(
            index: index,
          );
        },
        childCount: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: CustomScrollView(
        slivers: [
          _buildBox(),
          _buildStickBox(),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: _buildSliverGrid(),
          ),
          _buildSliverList(),
        ],
      ),
    );
  }
}

class FixedPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  FixedPersistentHeaderDelegate({
    required this.height,
  });

  final double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: height,
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text(
        "FixedPersistentHeader",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant FixedPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.height != height;
  }
}

class ShowOnScreenSPHD extends SliverPersistentHeaderDelegate {
  ShowOnScreenSPHD({required this.height});

  final double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: height,
      alignment: Alignment.center,
      color: Colors.orange,
      child: const Text(
        "ShowOnScreenSPHD",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => height;

  @override
  // TODO: implement minExtent
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant ShowOnScreenSPHD oldDelegate) {
    return oldDelegate.height != height;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration {
    return const PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: double.infinity,
    );
  }
}

class FlexibleSPHD extends SliverPersistentHeaderDelegate {
  FlexibleSPHD({
    required this.minHeight,
    required this.maxHeight,
  });

  /// 最小高度
  final double minHeight;

  ///
  final double maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double progress = shrinkOffset / (maxHeight - minHeight);
    progress = progress > 1 ? 1 : progress;

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: Color.lerp(Colors.blue, Colors.red, progress),
          alignment: Alignment.center,
        ),
        Opacity(
          opacity: 1 - progress,
          child: Image.network(
            Common.urlOne,
            fit: BoxFit.fill,
          ),
        ),
        Align(
          alignment: AlignmentTween(
            begin: const Alignment(0, -0.8),
            end: const Alignment(0, 0),
          ).transform(progress),
          child: Text(
            "FixedPersistentHeader",
            style: TextStyle(
              color: progress > 0.6 ? Colors.white : Colors.blue,
              fontSize: Tween(begin: 20.0, end: 16.0).transform(progress),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

    // return Container(
    //   color: Color.lerp(Colors.blue, Colors.red, progress),
    //   alignment: Alignment.center,
    //   child: const Text(
    //     "FixedPersistentHeader",
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 16,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant FlexibleSPHD oldDelegate) {
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight;
  }
}
