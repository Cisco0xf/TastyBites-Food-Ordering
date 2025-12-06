import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomLocalizationDelegate {
  late Locale locale;

  CustomLocalizationDelegate({required this.locale});

  static CustomLocalizationDelegate? of({required BuildContext context}) {
    return Localizations.of<CustomLocalizationDelegate>(
      context,
      CustomLocalizationDelegate,
    );
  }

  late Map<String, String> _localizationValues;

  Future<void> loadAndReadJsonFilse() async {
    String getJsonPath = await rootBundle.loadString(
      "asstes/langauges/${locale.languageCode}.json",
    );

    Map<String, dynamic> jsonMap = json.decode(getJsonPath);

    _localizationValues = jsonMap.map(
      (key, value) {
        return MapEntry(
          key,
          value.toString(),
        );
      },
    );
  }

  String getValueFromMap({required String key}) {
    String value = _localizationValues[key] ?? "";
    return value;
  }

  static const LocalizationsDelegate<CustomLocalizationDelegate> delegate =
      _AppLocalizationDelegate();
}

class _AppLocalizationDelegate
    extends LocalizationsDelegate<CustomLocalizationDelegate> {
  const _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    List<Locale> supportedLocales = const <Locale>[
      Locale("en"),
      Locale("ar"),
      Locale("ur"),
    ];

    bool isSupported = supportedLocales.contains(locale);
    return isSupported;
  }

  @override
  Future<CustomLocalizationDelegate> load(Locale locale) async {
    CustomLocalizationDelegate localizationDelegate =
        CustomLocalizationDelegate(locale: locale);

    await localizationDelegate.loadAndReadJsonFilse();

    return localizationDelegate;
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<CustomLocalizationDelegate> old,
  ) {
    return true;
  }
}

extension JsonValue on String {
  String localeValue({required BuildContext context}) {
    String value = CustomLocalizationDelegate.of(context: context)!
        .getValueFromMap(key: this);
    return value;
  }
}
