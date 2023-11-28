import 'package:flutter/material.dart';
import 'dart:math' as math;

class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({
    Key? key,
  }) : super(key: key);

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  late PageController _pageController;

  ///
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _pageController.addListener(() {
      setState(() {
        pageOffset = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: _pageController,
        children: [
          SlidingCard(
            name: 'Shenzhen GLOBAL DESIGN AWARD 2018',
            date: '4.20-30',
            assetName: 'steve-johnson.jpeg',
            offset: pageOffset,
          ),
          SlidingCard(
            name: 'Dawan District, Guangdong Hong Kong and Macao',
            date: '4.28-31',
            assetName: 'rodion-kutsaev.jpeg',
            offset: pageOffset - 1,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  const SlidingCard({
    Key? key,
    this.name = '',
    this.date = '',
    this.assetName = '',
    this.offset = 0.0,
  }) : super(key: key);

  ///
  final String name;

  ///
  final String date;

  ///
  final String assetName;

  ///
  final double offset;

  @override
  Widget build(BuildContext context) {
    /// 高斯函数
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));

    // print('print 15:25: ${gauss}');

    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      // offset: Offset(0, 0),
      child: Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/$assetName',
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({
    Key? key,
    this.name = '',
    this.date = '',
    this.offset = 0.0,
  }) : super(key: key);

  ///
  final String name;

  ///
  final String date;

  ///
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: const Text(
                      'Reserve',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: const Text(
                  '0.00 \$',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
