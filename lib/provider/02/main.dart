import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wtoolset/provider/01/model/counter_model.dart';
import 'package:wtoolset/provider/01/view/my_app.dart';

void main() {
  final counter = CounterModel();
  const textSize = 48;

  runApp(Provider<int>.value(
    value: textSize,
    child: ChangeNotifierProvider.value(
      value: counter,
      child: const MyApp(),
    ),
  ));
}
