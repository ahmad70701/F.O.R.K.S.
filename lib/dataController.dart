import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class newEntrydataController {
  //properties
  Map<String?, Map<String, dynamic>> mappedEntries = {};
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

  String? serviceErrorMessage;
  bool showServiceError = false;

  String? restaurantName;
  double? mainDishValue;
  double? sideLineValue;
  double? drinkValue;
  double? ambienceValue;
  double? locationValue;
  double? priceValue;
  double? serviceValue;

  //Constructor
  newEntrydataController();

  //methods
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

  Future<void> loadDataForNewEntry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonMapString = prefs.getString('entries');

    if (jsonMapString != null) {
      Map<String, dynamic> decodedMap = jsonDecode(jsonMapString);
      mappedEntries.addAll(decodedMap.cast<String?, Map<String, dynamic>>());
    }
  }

  Future<void> handleSubmit() async {
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
    mappedEntries.addAll({restaurantName: entry});
    String jsonString = jsonEncode(mappedEntries);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('entries', jsonString);
  }
}

class ListOfRestDataController {
  //Properties
  Map<String?, dynamic> mappedEntries = {};

  //Contstructor
  ListOfRestDataController();

  //Methods
  Future<Map<String?, dynamic>> loadDataForHome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonMapString = prefs.getString('entries');
    Map<String?, dynamic> newMappedEntries = {};
    if (jsonMapString != null) {
      Map<String?, dynamic> decodedJsonMap = jsonDecode(jsonMapString);
      newMappedEntries.addAll(decodedJsonMap.cast<String?, dynamic>());
    }
    return newMappedEntries;
  }

  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    mappedEntries = {};
  }
}
