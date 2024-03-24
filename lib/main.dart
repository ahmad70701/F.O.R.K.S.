import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
        body: MainAppForm(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          
          },
          child: Text('+'),
        ),
      ),
    );
  }
}

class MainAppForm extends StatefulWidget {
  @override
  _MainAppFormState createState() => _MainAppFormState();
}

class _MainAppFormState extends State<MainAppForm> {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter restaurant name:',
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Main Dish (0-25):',
                errorText: showMainDishError ? mainDishErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
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
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Sideline (0-15):',
                errorText: showSideLineError ? sideLineErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
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
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Drink (0-10):',
                errorText: showDrinkError ? drinkErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
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
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Ambience (0-15):',
                errorText: showAmbienceError ? ambienceErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
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
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Location (0-10):',
                errorText: showLocationError ? locationErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
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
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Price (0-15):',
                errorText: showPriceError ? priceErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 10) {
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
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Service (0-10):',
                errorText: showServiceError ? ServiceErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Sideline (0-10):',
                errorText: showSideLineError ? sideLineErrorMessage : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    double? val = double.tryParse(value);
                    if (val == null || val < 0 || val > 10) {
                      sideLineErrorMessage = 'Enter a number between 0 and 10';
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
          
        ],
      ),
    );
  }
}
