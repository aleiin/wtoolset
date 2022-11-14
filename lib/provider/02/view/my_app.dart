import 'package:flutter/material.dart';
import 'package:wtoolset/provider/01/view/first_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const FirstScreen(),
    );
  }
}
