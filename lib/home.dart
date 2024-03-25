import 'package:flutter/material.dart';
import 'package:flutter_application_1/newEntry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
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
        body: HomeApp(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  NewEntry()),
          );
          },
          child: Text("+"),
        ),
      ),
    );
  }
}
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeApp createState() => _HomeApp();
}

class _HomeApp extends State<MainAppForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
    );
  }
}

Future<void> _loadData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getDouble('mainDishValue'));
}
