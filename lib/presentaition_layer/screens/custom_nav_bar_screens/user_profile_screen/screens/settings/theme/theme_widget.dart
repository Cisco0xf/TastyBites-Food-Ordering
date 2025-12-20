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
    return Consumer<ThemeNotifier>(
      builder: (context, mode, child) {
        final style = TextStyle(
          fontFamily:
              context.isEnglish ? FontFamily.mainFont : FontFamily.mainArabic,
        );
        
        return Column(
          children: <Widget>[
            RadioListTile(
              value: false,
              title: Text("light".localeValue(context: context), style: style),
              groupValue: mode.isDark,
              onChanged: (_) async => await mode.switchTheme(),
            ),
            const Divider(),
            RadioListTile(
              value: true,
              title: Text("dark".localeValue(context: context), style: style),
              groupValue: mode.isDark,
              onChanged: (_) async => await mode.switchTheme(),
            ),
          ],
        );
      },
    );
  }
}
