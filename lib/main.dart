import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to FORKS!'),
          centerTitle: true,
          shadowColor: Colors.amber,
          backgroundColor: Colors.blueGrey[300],
        ),
      ),
    );
  }
}
