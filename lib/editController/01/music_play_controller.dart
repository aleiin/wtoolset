// import 'package:flutter/material.dart';
//
// class MusicPlayController with ChangeNotifier {
//   /// 构造函数
//   MusicPlayController({this.animating = true});
//
//   ///
//   bool animating;
//
//   /// 开始
//   void play() {
//     animating = true;
//     notifyListeners();
//   }
//
//   /// 结束
//   void stop() {
//     animating = false;
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     animating = false;
//     super.dispose();
//   }
// }
//
// class PlayController {
//   bool animating;
//
//   Function(bool animating)? listener;
//   Function()? voidListener;
//
//   PlayController({this.animating = true});
//
//   void addListener(Function(bool animating)? listener) {
//     this.listener = listener;
//   }
//
//   void addVoidListener(Function() listener) {
//     voidListener = listener;
//   }
//
//   /// 开始
//   void play() {
//     animating = true;
//     listener!(animating);
//     // voidListener?();
//   }
//
//   /// 结束
//   void stop() {
//     animating = false;
//     listener!(animating);
//     // voidListener!();
//   }
//
//   void dispose() {
//     animating = false;
//   }
// }
