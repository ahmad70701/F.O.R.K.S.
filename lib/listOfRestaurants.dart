// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/newEntry.dart';
import 'package:flutter_application_1/dataController.dart';

class ListOfRest extends StatelessWidget {
  const ListOfRest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: listApp());
  }
}

class listApp extends StatefulWidget {
  const listApp({super.key});

  @override
  _listApp createState() => _listApp();
}

class _listApp extends State<listApp> {
  ListOfRestDataController dataController = ListOfRestDataController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
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
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dataController.mappedEntries.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to F.O.R.K.'),
          centerTitle: true,
          shadowColor: Colors.amber,
          backgroundColor: Colors.blueGrey[300],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await _loadData();
          },
          child: const Column(
            children: [
              Center(
                child: Text("There is nothing here!"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewEntry()),
            );
            setState(() {
              _loadData();
            });
          },
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to F.O.R.K.'),
          centerTitle: true,
          shadowColor: Colors.amber,
          backgroundColor: Colors.blueGrey[300],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _loadData();
            });
          },
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                  itemCount: dataController.mappedEntries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                            'Restaurant Name: ${dataController.mappedEntries[dataController.mappedEntries.keys.elementAt(index)]['restaurantName']}'),
                        onTap: () => {},
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
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      clearAll();
                    });
                  },
                  child: const Text("Clear"),
                ),
              ),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewEntry()),
            );
            setState(() {
              _loadData();
            });
          },
          child: const Icon(Icons.add),
        ),
      );
    }
  }
}
