import 'package:flutter/material.dart';
import 'home.dart';

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.grey, primaryColor: Colors.blue),
    debugShowCheckedModeBanner: false,
  ));
}
