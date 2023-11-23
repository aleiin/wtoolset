import 'package:flutter/material.dart';

/// 上层视图
class TopView extends StatelessWidget {
  const TopView({
    Key? key,
    this.onLeft,
    this.onRight,
  }) : super(key: key);

  ///
  final VoidCallback? onLeft;

  ///
  final VoidCallback? onRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQueryData.fromView(View.of(context)).viewPadding.top,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xffd8e5eeff),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.menu),
                          ),
                          onPressed: () {
                            onLeft?.call();
                          },
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xffd5e2ecff),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search),
                                Text('抢先体验！用A唱英文歌'),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              // color: Colors.orange,
                              color: Color(0xffd8e5eeff),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.menu),
                          ),
                          onPressed: () {
                            onRight?.call();
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(4, (index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              margin:
                                  EdgeInsets.only(left: index == 0 ? 0 : 10),
                              decoration: BoxDecoration(
                                color: index == 0 ? Colors.black : null,
                                // color: Colors.black,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Text(
                                '推荐',
                                style: TextStyle(
                                  color:
                                      index == 0 ? Colors.white : Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xffd8e5eeff),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(5, (index) {
                            return Container(
                              width: 100,
                              height: 150,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 12),
                      child: Row(
                        children: [
                          const Text(
                            '每日主题音乐',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color(0xffd8e5eeff),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.refresh,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color(0xffd8e5eeff),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(5, (index) {
                          return Container(
                            width: 300,
                            height: 350,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 12),
                      child: Row(
                        children: [
                          const Text(
                            '根据最近收听推荐',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color(0xffd8e5eeff),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.refresh,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color(0xffd8e5eeff),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(5, (index) {
                          return Container(
                            width: 300,
                            height: 350,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 12,
                        bottom: MediaQueryData.fromView(View.of(context))
                            .viewPadding
                            .bottom),
                    color: const Color(0xffbfc2d0ff),
                    child: const Column(
                      children: [
                        Icon(Icons.home),
                        Text('首页'),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
