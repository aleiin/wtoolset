import 'package:flutter/material.dart';

extension NavigatorExtension on Navigator {
  Future<T?> pushRoute<T>(BuildContext context, Widget widget) async {
    return await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
