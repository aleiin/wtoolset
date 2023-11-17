import 'package:flutter/material.dart';
import 'package:wtoolset/performance/01/card.dart';
import 'package:wtoolset/performance/01/data.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("小店"),
      // ),
      body: Column(
        children: [
          const MyCard(
            height: 240,
            color: Colors.blue,
            child: Stack(
              children: [
                Text("新货"),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                MyCard(
                  width: 120,
                  color: Colors.red,
                  child: Text("家具"),
                ),
                MyCard(
                  width: 200,
                  color: Colors.green,
                  child: Text("唱片"),
                ),
                MyCard(
                  width: 160,
                  color: Colors.amber,
                  child: Text("单车"),
                ),
                MyCard(
                  width: 160,
                  color: Colors.teal,
                  child: Text("眼镜"),
                ),
              ],
            ),
          ),
          MyCard(
            height: 160,
            color: Colors.indigo,
            child: Stack(
              children: [
                OverflowBox(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const NewWidget(),
                  ),
                ),
                const Text(
                  "抢购",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  int promoAmount = 0;

  @override
  void initState() {
    super.initState();
    promotions.listen((event) {
      if (mounted) setState(() => promoAmount = event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      promoAmount.toString(),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
