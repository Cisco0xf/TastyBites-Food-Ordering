import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/theming/theme_provider.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, mode, child) {
        return Column(
          children: <Widget>[
            RadioListTile(
              value: "light",
              title: Text(
                "light".localeValue(context: context),
                style: TextStyle(
                  fontFamily: context.isEnglish
                      ? FontFamily.mainFont
                      : FontFamily.mainArabic,
                ),
              ),
              groupValue: mode.currentTheme,
              onChanged: (lightTheme) {
                mode.changeAppTheme(
                  userChoice: lightTheme as String,
                );
                mode.changeAppColors;
              },
            ),
            const Divider(),
            RadioListTile(
              value: "dark",
              title: Text(
                "dark".localeValue(context: context),
                style: TextStyle(
                  fontFamily: context.isEnglish
                      ? FontFamily.mainFont
                      : FontFamily.mainArabic,
                ),
              ),
              groupValue: mode.currentTheme,
              onChanged: (darkTheme) {
                mode.changeAppTheme(
                  userChoice: darkTheme as String,
                );
                mode.changeAppColors;
              },
            ),
          ],
        );
      },
    );
  }
}
