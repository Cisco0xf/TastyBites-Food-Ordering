import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/theming/theme_provider.dart';
import 'package:provider/provider.dart';

extension IsThemeLight on BuildContext {
  bool get isLight {
    bool isLight = !watch<ThemeNotifier>().isDark;
    return isLight;
  }
}
