import 'package:flutter/material.dart';
import 'package:ungpicpost/widget/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lime,
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
        primaryIconTheme: IconThemeData(color: Colors.black),
      ),
      home: Home(),
    );
  }
}
