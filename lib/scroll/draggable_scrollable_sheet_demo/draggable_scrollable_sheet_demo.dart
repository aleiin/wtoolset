import 'package:flutter/material.dart';

class DraggableScrollableSheetDemo extends StatelessWidget {
  DraggableScrollableSheetDemo({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!,
    Colors.red[50]!,
    Colors.red[100]!,
    Colors.red[200]!,
    Colors.red[300]!,
    Colors.red[400]!,
    Colors.red[500]!,
    Colors.red[600]!,
    Colors.red[700]!,
    Colors.red[800]!,
    Colors.red[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DraggableScrollableSheet"),
      ),
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.2,
          maxChildSize: 0.5,
          expand: true,
          builder: (BuildContext context, ScrollController scrollController) =>
              ListView.builder(
            controller: scrollController,
            itemCount: data.length,
            itemBuilder: buildColorItem,
          ),
        ),
      ),
    );
  }

  Widget buildColorItem(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      color: data[index],
      child: Text(
        colorString(data[index]),
        style: const TextStyle(color: Colors.white, shadows: [
          Shadow(
            color: Colors.black,
            offset: Offset(.5, .5),
            blurRadius: 2,
          )
        ]),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
