import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtoolset/provider/01/model/counter_model.dart';
import 'package:wtoolset/provider/01/view/goods_list_screen.dart';
import 'package:wtoolset/provider/01/view/second_page.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    print('第一个界面');

    return Scaffold(
      appBar: AppBar(
        title: const Text("FirstPage"),
      ),
      body: Center(
        child: Text(
          "value: ${_counter.count}",
          style: TextStyle(
            fontSize: textSize,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                // return const SecondPage();
                return const GoodsListScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
