import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/statemanagement/localization/localization_provider.dart';
import 'package:provider/provider.dart';

extension LanguageOfApp on BuildContext {
  bool get isEnglish {
    LocalizationProvider localization = Provider.of<LocalizationProvider>(
      this,
      listen: false,
    );
    bool isEnglish = localization.currentLocale == "en";
    return isEnglish;
  }

  bool get isArabicEg {
    LocalizationProvider localization = Provider.of<LocalizationProvider>(
      this,
      listen: false,
    );
    bool isEnglish = localization.currentLocale == "ur";
    return isEnglish;
  }
}
