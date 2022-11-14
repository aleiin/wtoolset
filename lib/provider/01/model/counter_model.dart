import 'package:flutter/cupertino.dart';

class CounterModel with ChangeNotifier {
  int _count = 1;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
