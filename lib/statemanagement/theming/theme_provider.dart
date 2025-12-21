import 'package:flutter/material.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/statemanagement/cloud_firestore/sync_locale_with_cloud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveTheme {
  static String get _key => PrefsKeys.THEME_KEY;

  static Future<void> saveLastTheme(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_key, isDark);
  }

  static Future<bool> getThemeValueFromDb() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool isDark = prefs.getBool(_key) ?? false;

    return isDark;
  }

  static Future<void> initThemeStateFromDb() async {
    final bool isDark = await getThemeValueFromDb();

    navigationKey.currentContext!
        .read<ThemeNotifier>()
        .initThemeFromLocaleDB(isDark);

    Log.log("Theme has been init... | isDak => $isDark");
  }
}

class ThemeNotifier extends ChangeNotifier {
  bool isDark = false;

  SaveSyncPref get themePrefs => const SaveSyncPref(
        key: PrefsKeys.THEME_KEY,
      );

  Future<void> switchTheme() async {
    isDark = !isDark;

    switchAppColors();

    await themePrefs.saveValueToPref(isInit: isDark);

    notifyListeners();
  }

  Brightness get appBrightnss => isDark ? Brightness.dark : Brightness.light;

  void switchAppColors() {
    if (isDark) {
      SwitchColor.bgColor = DarkColors.bgColor;
      SwitchColor.primaryO = DarkColors.primaryO;
      SwitchColor.secondary = DarkColors.secondary;
      SwitchColor.accent = DarkColors.accent;
      SwitchColor.borderColor = DarkColors.borderColor;
      SwitchColor.btnColor = DarkColors.btnColor;
      SwitchColor.fillColor = DarkColors.fillColor;
      SwitchColor.txtColor = DarkColors.txtColor;
      SwitchColor.txtColor = DarkColors.txtColor;

      SwitchColor.receiptColor = DarkColors.receiptColor;
      SwitchColor.itemGradeint = DarkColors.itemGradeint;
      SwitchColor.cartItem = DarkColors.cartItem;
      SwitchColor.base = DarkColors.base;
      SwitchColor.checkout = DarkColors.checkout;
    } else {
      SwitchColor.bgColor = LightColors.bgColor;
      SwitchColor.primaryO = LightColors.primaryO;
      SwitchColor.secondary = LightColors.secondary;
      SwitchColor.accent = LightColors.accent;
      SwitchColor.borderColor = LightColors.borderColor;
      SwitchColor.btnColor = LightColors.btnColor;
      SwitchColor.fillColor = LightColors.fillColor;
      SwitchColor.txtColor = LightColors.txtColor;

      SwitchColor.receiptColor = LightColors.receiptColor;
      SwitchColor.itemGradeint = LightColors.itemGradeint;
      SwitchColor.cartItem = LightColors.cartItem;
      SwitchColor.base = LightColors.base;
      SwitchColor.checkout = LightColors.checkout;
    }

    notifyListeners();
  }

  void initThemeFromLocaleDB(bool isDarkDB) {
    isDark = isDarkDB;
    switchAppColors();
  }
}
