import 'package:flutter/material.dart';

class Airplane extends StatefulWidget {
  const Airplane({Key? key}) : super(key: key);

  @override
  _AirplaneState createState() => _AirplaneState();
}

class _AirplaneState extends State<Airplane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("飞机"),
    );
  }
}
