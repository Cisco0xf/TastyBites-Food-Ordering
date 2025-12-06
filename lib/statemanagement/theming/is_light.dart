import 'package:flutter/material.dart';

extension IsThemeLight on BuildContext {
  bool get isLight {
    bool isLight = Theme.of(this).brightness == Brightness.light;
    return isLight;
  }
}
