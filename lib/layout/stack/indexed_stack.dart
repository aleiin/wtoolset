import 'package:flutter/material.dart';
import 'package:wtoolset/widget/custom_widget.dart';

///
class IndexedStackDemo extends StatelessWidget {
  const IndexedStackDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      titleLabel: 'IndexedStack',
      body: GestureDetector(
        onTap: () {},
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(4, (index) {
            return Positioned(
              top: index * 80,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 100,
                color: Colors.primaries[index % 4],
              ),
            );
          }),
        ),
      ),
    );
  }
}
