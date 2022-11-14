import 'package:flutter/material.dart';
import 'package:wtoolset/common.dart';
import 'package:wtoolset/scroll/01/item_box.dart';
import 'package:wtoolset/scroll/01/sliver_pinned_header.dart';
import 'package:wtoolset/scroll/01/sliver_snap_header.dart';

///
class NestDemo extends StatefulWidget {
  const NestDemo({Key? key}) : super(key: key);

  @override
  _NestDemoState createState() => _NestDemoState();
}

class _NestDemoState extends State<NestDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = <String>["关注", "推荐", "热榜", "精选"];

  final List<int> data = List.generate(60, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildAppbar() {
    return SliverAppBar(
      expandedHeight: 180,
      title: const Text("测试"),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Image.network(
          Common.urlOne,
          fit: BoxFit.cover,
        ),
      ),
      pinned: true,
      bottom: TabBar(
        controller: _tabController,
        tabs: _tabs
            .map((String name) => Tab(
                  text: name,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildTabView() {
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        children: [
          buildScrollPage("Colors.red"),
          buildScrollPage("Colors.amber"),
        ],
      ),
    );
  }

  Widget buildScrollPage(String name) {
    return Builder(builder: (context) {
      return CustomScrollView(
        key: PageStorageKey<String>(name),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          _buildBox(Colors.deepOrange),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: _buildSliverGrid(),
          ),
          _buildSliverList(),
        ],
      );
    });
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        _buildItemByIndex,
        childCount: data.length,
      ),
    );
  }

  Widget _buildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        _buildItemByIndex,
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

  Widget _buildItemByIndex(BuildContext context, int index) {
    return ItemBox(
      index: data[index],
    );
  }

  Widget _buildBox(Color color) {
    return SliverToBoxAdapter(
      child: Container(
        height: 60,
        color: color,
      ),
    );
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return [
      const SliverSnapHeader(
        child: SearchBar(),
      ),
      SliverOverlapAbsorber(
        sliver: SliverPinnedHeader(
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: _tabs
                .map((String name) => Tab(
                      text: name,
                    ))
                .toList(),
          ),
        ),
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: [
    //       _buildAppbar(),
    //       _buildTabView(),
    //     ],
    //   ),
    // );

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            // Container(
            //   color: Colors.white,
            //   height: MediaQuery.of(context).padding.top,
            // ),
            Expanded(
              child: NestedScrollView(
                // headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                //   print('print 09:53: ${innerBoxIsScrolled}');
                //   return [
                //     SliverOverlapAbsorber(
                //       sliver: _buildAppbar(),
                //       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                //     ),
                //   ];
                // },
                floatHeaderSlivers: true,
                headerSliverBuilder: _buildHeader,
                body: TabBarView(
                  controller: _tabController,
                  children: _tabs.map(buildScrollPage).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(35 + 8 * 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(Common.urlOne),
          ),
          Expanded(
            child: Container(
              height: 35,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: const TextField(
                autofocus: false,
                cursorColor: Colors.blue,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF3F6F9),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.only(right: 0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(35 / 2)),
                  ),
                  hintText: "搜索文章",
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 3,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Icon(Icons.assignment_turned_in_outlined),
              Text(
                '已签',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
