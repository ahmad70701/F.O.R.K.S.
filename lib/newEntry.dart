import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NewEntry extends StatelessWidget {
  const NewEntry({super.key});

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
        body: MainAppForm(),
      ),
    );
  }
}

class MainAppForm extends StatefulWidget {
  @override
  _MainAppFormState createState() => _MainAppFormState();
}

class _MainAppFormState extends State<MainAppForm> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  List<Map<String, dynamic>> entries = [];

  String? mainDishErrorMessage;
  bool showMainDishError = false;

  String? sideLineErrorMessage;
  bool showSideLineError = false;

  String? drinkErrorMessage;
  bool showDrinkError = false;

  String? ambienceErrorMessage;
  bool showAmbienceError = false;

  String? locationErrorMessage;
  bool showLocationError = false;

  String? priceErrorMessage;
  bool showPriceError = false;

  String? ServiceErrorMessage;
  bool showServiceError = false;

  String? restaurantName;
  double? mainDishValue;
  double? sideLineValue;
  double? drinkValue;
  double? ambienceValue;
  double? locationValue;
  double? priceValue;
  double? serviceValue;

  double? totalCalculation() {
    double? total = 0;
    double? numberGiven = ((mainDishValue ?? 0) +
        (sideLineValue ?? 0) +
        (drinkValue ?? 0) +
        (ambienceValue ?? 0) +
        (locationValue ?? 0) +
        (priceValue ?? 0) +
        (serviceValue ?? 0));
    total += (mainDishValue != null) ? 25 : 0;
    total += (sideLineValue != null) ? 15 : 0;
    total += (drinkValue != null) ? 10 : 0;
    total += (ambienceValue != null) ? 15 : 0;
    total += (locationValue != null) ? 10 : 0;
    total += (priceValue != null) ? 15 : 0;
    total += (serviceValue != null) ? 10 : 0;

    return numberGiven / total * 100;
  }

  Future<void> _handleSubmit() async {
    Map<String, dynamic> entry = {
      'restaurantName': restaurantName ?? '',
      'mainDishValue': mainDishValue ?? 0,
      'sideLineValue': sideLineValue ?? 0,
      'drinkValue': drinkValue ?? 0,
      'ambienceValue': ambienceValue ?? 0,
      'locationValue': locationValue ?? 0,
      'priceValue': priceValue ?? 0,
      'serviceValue': serviceValue ?? 0,
      'Score': totalCalculation() ?? 0,
    };
    entries.add(entry);
    String jsonString = jsonEncode(entries);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('entries', jsonString);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Entry saved!'),
      ),
    );
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonListString = prefs.getString('entries');

    if (jsonListString != null) {
      List<dynamic> jsonList = jsonDecode(jsonListString);
      jsonList.forEach((element) {
        entries.add(element);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter restaurant name:',
              ),
              onChanged: (value) => {restaurantName = value},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Main Dish (0-25):',
                errorText: showMainDishError ? mainDishErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  mainDishValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 25) {
                      mainDishErrorMessage = 'Enter a number between 0 and 25';
                      showMainDishError = true;
                    } else {
                      mainDishErrorMessage = null;
                      showMainDishError = false;
                    }
                  } else {
                    mainDishErrorMessage = null;
                    showMainDishError = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Sideline (0-15):',
                errorText: showSideLineError ? sideLineErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  sideLineValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 15) {
                      sideLineErrorMessage = 'Enter a number between 0 and 15';
                      showSideLineError = true;
                    } else {
                      sideLineErrorMessage = null;
                      showSideLineError = false;
                    }
                  } else {
                    sideLineErrorMessage = null;
                    showSideLineError = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Drink (0-10):',
                errorText: showDrinkError ? drinkErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  drinkValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 10) {
                      drinkErrorMessage = 'Enter a number between 0 and 10';
                      showDrinkError = true;
                    } else {
                      drinkErrorMessage = null;
                      showDrinkError = false;
                    }
                  } else {
                    drinkErrorMessage = null;
                    showDrinkError = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Ambience (0-15):',
                errorText: showAmbienceError ? ambienceErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  ambienceValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 15) {
                      ambienceErrorMessage = 'Enter a number between 0 and 15';
                      showAmbienceError = true;
                    } else {
                      ambienceErrorMessage = null;
                      showAmbienceError = false;
                    }
                  } else {
                    ambienceErrorMessage = null;
                    showAmbienceError = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Location (0-10):',
                errorText: showLocationError ? locationErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  locationValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 10) {
                      locationErrorMessage = 'Enter a number between 0 and 10';
                      showLocationError = true;
                    } else {
                      locationErrorMessage = null;
                      showLocationError = false;
                    }
                  } else {
                    locationErrorMessage = null;
                    showLocationError = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Price (0-15):',
                errorText: showPriceError ? priceErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  priceValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 15) {
                      priceErrorMessage = 'Enter a number between 0 and 15';
                      showPriceError = true;
                    } else {
                      priceErrorMessage = null;
                      showPriceError = false;
                    }
                  } else {
                    priceErrorMessage = null;
                    showPriceError = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              // textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Service (0-10):',
                errorText: showServiceError ? ServiceErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  serviceValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 10) {
                      ServiceErrorMessage = 'Enter a number between 0 and 10';
                      showServiceError = true;
                    } else {
                      ServiceErrorMessage = null;
                      showServiceError = false;
                    }
                  } else {
                    ServiceErrorMessage = null;
                    showServiceError = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Score: ${(totalCalculation() ?? 0).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => {
                  _handleSubmit(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()))
                  
                  },
                child: Text("Save"),
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
  }
}
