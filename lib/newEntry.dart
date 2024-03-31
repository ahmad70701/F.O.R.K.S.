import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/listOfRestaurants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_application_1/dataController.dart';

class NewEntry extends StatelessWidget {
  const NewEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to FORKS!'),
          centerTitle: true,
          shadowColor: Colors.amber,
          backgroundColor: Colors.blueGrey[300],
        ),
        body: MainAppForm(),
      );
  }
}

class MainAppForm extends StatefulWidget {
  @override
  _MainAppFormState createState() => _MainAppFormState();
}

class _MainAppFormState extends State<MainAppForm> {
  newEntrydataController newDataController = new newEntrydataController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    newDataController.loadDataForNewEntry();
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
              focusNode: _focusNode,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter restaurant name:',
              ),
              onChanged: (value) => {newDataController.restaurantName = value},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Main Dish (0-25):',
                errorText: newDataController.showMainDishError
                    ? newDataController.mainDishErrorMessage
                    : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  newDataController.mainDishValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 25) {
                      newDataController.mainDishErrorMessage =
                          'Enter a number between 0 and 25';
                      newDataController.showMainDishError = true;
                    } else {
                      newDataController.mainDishErrorMessage = null;
                      newDataController.showMainDishError = false;
                    }
                  } else {
                    newDataController.mainDishErrorMessage = null;
                    newDataController.showMainDishError = false;
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
                errorText: newDataController.showSideLineError
                    ? newDataController.sideLineErrorMessage
                    : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  newDataController.sideLineValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 15) {
                      newDataController.sideLineErrorMessage =
                          'Enter a number between 0 and 15';
                      newDataController.showSideLineError = true;
                    } else {
                      newDataController.sideLineErrorMessage = null;
                      newDataController.showSideLineError = false;
                    }
                  } else {
                    newDataController.sideLineErrorMessage = null;
                    newDataController.showSideLineError = false;
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
                errorText: newDataController.showDrinkError
                    ? newDataController.drinkErrorMessage
                    : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  newDataController.drinkValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 10) {
                      newDataController.drinkErrorMessage =
                          'Enter a number between 0 and 10';
                      newDataController.showDrinkError = true;
                    } else {
                      newDataController.drinkErrorMessage = null;
                      newDataController.showDrinkError = false;
                    }
                  } else {
                    newDataController.drinkErrorMessage = null;
                    newDataController.showDrinkError = false;
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
                errorText: newDataController.showAmbienceError
                    ? newDataController.ambienceErrorMessage
                    : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  newDataController.ambienceValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 15) {
                      newDataController.ambienceErrorMessage =
                          'Enter a number between 0 and 15';
                      newDataController.showAmbienceError = true;
                    } else {
                      newDataController.ambienceErrorMessage = null;
                      newDataController.showAmbienceError = false;
                    }
                  } else {
                    newDataController.ambienceErrorMessage = null;
                    newDataController.showAmbienceError = false;
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
                errorText: newDataController.showLocationError
                    ? newDataController.locationErrorMessage
                    : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  newDataController.locationValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 10) {
                      newDataController.locationErrorMessage =
                          'Enter a number between 0 and 10';
                      newDataController.showLocationError = true;
                    } else {
                      newDataController.locationErrorMessage = null;
                      newDataController.showLocationError = false;
                    }
                  } else {
                    newDataController.locationErrorMessage = null;
                    newDataController.showLocationError = false;
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
                errorText: newDataController.showPriceError
                    ? newDataController.priceErrorMessage
                    : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  newDataController.priceValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 15) {
                      newDataController.priceErrorMessage =
                          'Enter a number between 0 and 15';
                      newDataController.showPriceError = true;
                    } else {
                      newDataController.priceErrorMessage = null;
                      newDataController.showPriceError = false;
                    }
                  } else {
                    newDataController.priceErrorMessage = null;
                    newDataController.showPriceError = false;
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
                errorText: newDataController.showServiceError
                    ? newDataController.serviceErrorMessage
                    : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  newDataController.serviceValue = double.tryParse(value);
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 10) {
                      newDataController.serviceErrorMessage =
                          'Enter a number between 0 and 10';
                      newDataController.showServiceError = true;
                    } else {
                      newDataController.serviceErrorMessage = null;
                      newDataController.showServiceError = false;
                    }
                  } else {
                    newDataController.serviceErrorMessage = null;
                    newDataController.showServiceError = false;
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
                'Score: ${(newDataController.totalCalculation() ?? 0).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  newDataController.handleSubmit();
                  Navigator.pop(context);
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
