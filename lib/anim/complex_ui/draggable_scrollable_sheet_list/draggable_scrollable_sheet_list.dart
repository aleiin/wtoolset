import 'package:flutter/material.dart';
import 'package:wtoolset/anim/complex_ui/draggable_scrollable_sheet_list/exhibition_bottom_sheet.dart';
import 'package:wtoolset/anim/complex_ui/draggable_scrollable_sheet_list/sliding_cards.dart';

class DraggableScrollableSheetList extends StatelessWidget {
  const DraggableScrollableSheetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('拖拽列表'),
      // ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 12,
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                child: const Text(
                  'Shenzhen',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const Row(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  MyTab(
                    text: '第一个',
                    isSelected: false,
                  ),
                  MyTab(
                    text: '第二个',
                    isSelected: true,
                  ),
                  MyTab(
                    text: '第三个',
                    isSelected: false,
                  ),
                ],
              ),
              const SlidingCardsView(),
            ],
          ),
          const ExhibitionBottomSheet(),
        ],
      ),

      // body: DraggableScrollableSheet(
      //   // minChildSize: 0.15,
      //   // initialChildSize: 0.15,
      //   builder: (BuildContext context, ScrollController scrollController) {
      //     return AnimatedBuilder(
      //       animation: scrollController,
      //       builder: (BuildContext context, Widget? child) {
      //         double percentage = 100.0;
      //         if (scrollController.hasClients) {
      //           percentage = scrollController.position.viewportDimension /
      //               MediaQuery.of(context).size.height;
      //         }
      //
      //         return Container(
      //           width: MediaQuery.of(context).size.width,
      //           // height: 10 * percentage,
      //
      //           decoration: const BoxDecoration(
      //               color: Colors.orange,
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(10),
      //                 topRight: Radius.circular(10),
      //               )),
      //           child: Container(
      //             width: MediaQuery.of(context).size.width,
      //             child: ListView.builder(
      //               itemCount: 100,
      //               itemBuilder: (BuildContext context, int index) {
      //                 return Container(
      //                   width: MediaQuery.of(context).size.width,
      //                   height: 50,
      //                   alignment: Alignment.center,
      //                   color: Colors.accents[index % 5],
      //                   child: Text('第 $index 项'),
      //                 );
      //               },
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}

class MyTab extends StatelessWidget {
  const MyTab({
    Key? key,
    this.text = '标题',
    this.isSelected = false,
  }) : super(key: key);

  ///
  final String text;

  ///
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: isSelected ? 16 : 14,
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          Container(
            width: 20,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
