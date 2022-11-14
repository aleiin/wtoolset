import 'package:flutter/material.dart';
import 'package:wtoolset/provider/01/model/goods.dart';

class GoodsListProvider with ChangeNotifier {
  final List<Goods> _goodsList = List.generate(
      10, (index) => Goods(isCollection: false, name: "Goods No. $index"));

  get goodList => _goodsList;

  get total => _goodsList.length;

  collect(int index) {
    var good = _goodsList[index];
    _goodsList[index] =
        Goods(isCollection: !good.isCollection, name: good.name);
    notifyListeners();
  }
}
