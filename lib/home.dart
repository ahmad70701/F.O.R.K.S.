import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/newEntry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_application_1/dataController.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to FORKS!'),
          centerTitle: true,
          shadowColor: Colors.amber,
          backgroundColor: Colors.blueGrey[300],
        ),
        body: HomeApp(),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
            Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => NewEntry()),
      );
    },
    child: const Icon(Icons.add),
  ),
),
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeApp createState() => _HomeApp();
}

class _HomeApp extends State<HomeApp> {
  ListOfRestDataController dataController = new ListOfRestDataController();

  @override
  void initState() {
    super.initState();
    _loadData()  ;
  }

  Future<void> _loadData()  async {
    Map<String?, dynamic> newMappedEntries =
        await dataController.loadDataForHome();
    setState(() {
      dataController.mappedEntries = newMappedEntries;
    });
  }

  Future<void> clearAll() async {
    await dataController.clearAllData();
    setState(() {
      dataController.mappedEntries = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dataController.mappedEntries.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          await _loadData()   ;
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
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewEntry()),
                    );
                    setState(() {
                      _loadData();
                    });
                  },
                  child: Text("+"),
                ),
                
              ),
            )
          ],
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _loadData()   ;
          });
        },
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: dataController.mappedEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                          'Restaurant Name: ${dataController.mappedEntries[dataController.mappedEntries.keys.elementAt(index)]['restaurantName']}'),
                      onTap: () => {
                      
                      },
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Score: ${dataController.mappedEntries[dataController.mappedEntries.keys.elementAt(index)]['Score'].toStringAsFixed(2)}'),
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
              child: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewEntry()),
                  );
                  setState(() {
                    _loadData();
                  });
                },
                child: Text("+"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () async {
                  setState(() {
                    clearAll();
                  });
                },
                child: Text("Clear All"),

              ),
            ),
          )
        ]),
      );
    }
  }
}
