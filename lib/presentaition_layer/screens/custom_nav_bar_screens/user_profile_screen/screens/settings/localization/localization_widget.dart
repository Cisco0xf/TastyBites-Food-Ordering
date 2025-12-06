import 'package:flutter/material.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/localization/localization_provider.dart';
import 'package:provider/provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localization, child) {
        return Column(
          children: <Widget>[
            RadioListTile(
              value: localization.appLanguages.first,
              groupValue: localization.currentLocale,
              onChanged: (language) {
                localization.chnageAppLocalization(
                    selectedLocale: language as String);
              },
              title: Text(
                "english".localeValue(context: context),
                style: const TextStyle(
                  fontFamily: FontFamily.mainFont,
                ),
              ),
            ),
            RadioListTile(
              value: localization.appLanguages[1],
              groupValue: localization.currentLocale,
              onChanged: (language) {
                localization.chnageAppLocalization(
                  selectedLocale: language as String,
                );
              },
              title: Text(
                "arabic".localeValue(context: context),
                style: const TextStyle(
                  letterSpacing: 0,
                  fontFamily: FontFamily.mainArabic,
                ),
              ),
            ),
            RadioListTile(
              value: localization.appLanguages.last,
              groupValue: localization.currentLocale,
              onChanged: (language) {
                localization.chnageAppLocalization(
                    selectedLocale: language as String);
              },
              title: Text(
                "arabic-EG".localeValue(context: context),
                style: const TextStyle(
                  letterSpacing: 0,
                  fontFamily: FontFamily.mainArabic,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
