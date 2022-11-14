import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtoolset/provider/01/model/counter_model.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('第二个界面');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Consumer2<CounterModel, int>(
        builder: (context, CounterModel counter, int textSize, _) {
          return Center(
            child: Text(
              "Value: ${counter.count}",
              style: TextStyle(
                fontSize: textSize.toDouble(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) {
          return FloatingActionButton(
            onPressed: counter.increment,
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
