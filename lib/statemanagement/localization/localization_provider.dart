import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/localization/last_localization.dart';

class LocalizationProvider with ChangeNotifier {
  List<String> appLanguages = [
    "en",
    "ar",
    "ur",
  ];
  
  late String currentLocale;

  LocalizationProvider() {
    currentLocale = appLanguages.first;
    initializeDatabase;
  }

  // Get instance from database

  final SaveLastLanguage _lastLanguage = SaveLastLanguage();

  SaveLastLanguage get lastLanguage => _lastLanguage;

  // Change App localzation

  void chnageAppLocalization({required String selectedLocale}) {
    // Change localization
    currentLocale = selectedLocale;
    log("Selected Locale : $currentLocale");
    // Save localization to database
    lastLanguage.putDataInDatabase(putedData: selectedLocale);
    notifyListeners();
  }

  // Initialize Localization from last value saved into database

  Future<void> get initializeDatabase async {
    String lastLocale = await lastLanguage.getDataFromDatabase();

    currentLocale = lastLocale;

    notifyListeners();
  }

  // Change locale in Material

  Locale get getAppLocale {
    if (currentLocale == "en") {
      return const Locale("en");
    } else if (currentLocale == "ar") {
      return const Locale("ar");
    } else {
      return const Locale("ur");
    }
  }
}
