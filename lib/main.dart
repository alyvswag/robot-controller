import 'package:flutter/material.dart';
import 'package:robot_controller/screens/input_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Robot Controller',
      home: NameInputScreen(),
    );
  }
}
