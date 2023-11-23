import 'package:flutter/material.dart';

/// 底部视图
class BottomView extends StatelessWidget {
  const BottomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        top: MediaQueryData.fromView(View.of(context)).viewPadding.top,
        right: 12,
        bottom: MediaQueryData.fromView(View.of(context)).viewPadding.bottom,
      ),
      width: MediaQueryData.fromView(View.of(context)).size.width / 1.2,
      height: MediaQuery.of(context).size.height,
      color: Colors.deepOrangeAccent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 4,
              ),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: const Row(
                children: [
                  Text('切换到标准版'),
                  Spacer(),
                  Text('立即切换'),
                  Icon(Icons.arrow_circle_right_rounded)
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Hi,、、、'),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: const Text(
                          '会员中心',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text('有效期至 2024-04-02'),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.black,
                    margin: const EdgeInsets.only(top: 12, bottom: 6),
                  ),
                  const Text('开通会员享20+项特权＞')
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double average = (constraints.maxWidth - 12 * 3) / 4;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: average,
                        child: Column(
                          children: [
                            Container(
                              width: average,
                              height: average,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.accents[index % 4],
                              ),
                            ),
                            Text('第$index项')
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            Column(
              children: List.generate(3, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Text('音乐服务'),
                    ),
                    Column(
                      children: List.generate(5, (index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          // color: Colors.orange,
                          child: Row(
                            children: [
                              const Icon(Icons.info),
                              const SizedBox(width: 10),
                              Text(
                                '这是标题, 是第$index项',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
