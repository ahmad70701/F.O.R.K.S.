import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/newEntry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeApp createState() => _HomeApp();
}

class _HomeApp extends State<HomeApp> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  List<Map<String, dynamic>> entries = [];
  Map<String?, dynamic> mappedEntries = {};
  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonMapString = prefs.getString('entries');
    if (jsonMapString != null) {
      Map<String?, dynamic> decodedJsonMap = jsonDecode(jsonMapString);
      Map<String?, dynamic> newMappedEntries = {};
      newMappedEntries.addAll(decodedJsonMap.cast<String?, dynamic>());

      setState(() {
        mappedEntries = newMappedEntries;
      });
    }
    print(mappedEntries);
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
    mappedEntries = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mappedEntries.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          await _loadData;
        },
        child: Column(
          children: [
            Center(
              child: Text("There is nothing here!"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewEntry()),
                    );
                    await _loadData();
                  },
                  child: Text("+"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[300],
                    foregroundColor: Colors.black,
                    shadowColor: Colors.black12,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await _loadData();
        },
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: mappedEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                          'Restaurant Name: ${mappedEntries[mappedEntries.keys.elementAt(index)]['restaurantName']}'),
                      onTap: () => {
                        print(mappedEntries.values.elementAt(index)['Score'])
                      },
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Score: ${mappedEntries[mappedEntries.keys.elementAt(index)]['Score'].toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewEntry()),
                  );
                  await _loadData();
                },
                child: Text("+"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  foregroundColor: Colors.black,
                  shadowColor: Colors.black12,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () async {
                  await clearSharedPreferences();
                },
                child: Text("Clear All"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  foregroundColor: Colors.black,
                  shadowColor: Colors.black12,
                ),
              ),
            ),
          )
        ]),
      );
    }
  }
}
