import 'package:countdown/screens/home.dart';
import 'package:flutter/material.dart';
void main() => runApp(CountdownApp());

class CountdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}