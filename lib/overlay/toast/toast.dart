//通过 Overlay 实现 Toast

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Toast {
  static void show({
    required BuildContext context,
    required String message,
  }) {
    //1、创建 overlayEntry
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.8,
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(message),
                  ),
                  color: Colors.grey.withOpacity(0.6),
                ),
              ),
            ),
          ),
        );
      },
    );

    //插入到 Overlay中显示 OverlayEntry
    Overlay.of(context).insert(overlayEntry);

    //延时两秒，移除 OverlayEntry
    Future.delayed(const Duration(seconds: 2)).then((value) {
      overlayEntry.remove();
    });
  }

  static OverlayEntry? overlayEntry;

  static void showTopWidget({
    required BuildContext context,
    required String message,
  }) {
    if (overlayEntry == null) {
      //1、创建 overlayEntry
      overlayEntry = OverlayEntry(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black12,
            body: AnnotatedRegion(
              value: SystemUiOverlayStyle.dark,
              child: Stack(
                children: [
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        overlayEntry!.remove();
                        overlayEntry = null;
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        color: Colors.orange.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 200,
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: GridView.custom(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        (
                          context,
                          index,
                        ) {
                          return GestureDetector(
                            onTap: () {},
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "lalalal",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          // return Positioned(
          //   top: MediaQuery.of(context).size.height * 0.8,
          //   child: Material(
          //     child: Container(
          //       width: MediaQuery.of(context).size.width,
          //       alignment: Alignment.center,
          //       child: Center(
          //         child: Card(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8),
          //             child: Text(message),
          //           ),
          //           color: Colors.grey.withOpacity(0.6),
          //         ),
          //       ),
          //     ),
          //   ),
          // );
        },
      );

      //插入到 Overlay中显示 OverlayEntry
      Overlay.of(context).insert(overlayEntry!);
    }

    // //延时两秒，移除 OverlayEntry
    // Future.delayed(const Duration(seconds: 2)).then((value) {
    //   overlayEntry!.remove();
    // });
  }
}
