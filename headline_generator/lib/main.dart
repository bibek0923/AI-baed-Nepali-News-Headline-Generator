
import 'package:flutter/material.dart';
import 'package:headline_generator/first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Nepali News Headline Generator')),
        body: FirstSCreen(),
      ),
    );
  }
}

