import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/statemanagement/cloud_firestore/sync_locale_with_cloud.dart';
import 'package:foodapp/statemanagement/theming/save_last_theme.dart';
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
/* 
class ThemeProvider with ChangeNotifier {
  final SaveLastTheme _lastTheme = SaveLastTheme();

  SaveLastTheme get lastTheme => _lastTheme;

  List<String> appTheme = [
    "light",
    "dark",
  ];

  late String currentTheme;

  ThemeProvider() {
    currentTheme = appTheme.last; // BUG was here
    initializeTheme;
    // changeAppColors;
  }

  void changeAppTheme({required String userChoice}) {
    if (userChoice == "light") {
      currentTheme = "light";
      // Put Theme in databse
      lastTheme.putDataInDatabase(
        putedData: userChoice,
      );
      log("User chioce fom if block $userChoice");
    } else {
      currentTheme = "dark";
      //Put Theme in Databse
      lastTheme.putDataInDatabase(
        putedData: userChoice,
      );
      log("User chioce fom if block $userChoice");
    }
    notifyListeners();
  }

  // Get Theme from Database

  Future<void> get initializeTheme async {
    String lastSavedTheme = await lastTheme.getDataFromDatabase();
    currentTheme = lastSavedTheme;
    log("Current theme fomn init :$currentTheme"); // Log
    log("Last Saved theme from database in init :$lastSavedTheme"); // Log
    notifyListeners();
  }

  Brightness get getAppTheme {
    if (currentTheme == "light") {
      return Brightness.light;
    } else {
      return Brightness.dark;
    }
  }

  /*  Future<void> get changeAppColors async {
    String lastSavedTheme = await lastTheme.getDataFromDatabase();

    if (lastSavedTheme == "light") {
      log("Current Theme fom isLight if block $currentTheme"); // Log
      SwitchColors.backgroundMianColor = AppLightColors.backgroundMianColor;
      SwitchColors.itemBackgoundColor = AppLightColors.itemBackgoundColor;

      SwitchColors.greenItemColor = AppLightColors.greenItemColor;
      SwitchColors.quantityButtonColor = AppLightColors.quantityButtonColor;
      SwitchColors.addToCartBGColor = AppLightColors.addToCartBGColor;
      SwitchColors.searchFieldFillColor = AppLightColors.searchFieldFillColor;
      SwitchColors.filterColor = AppLightColors.filterColor;
      SwitchColors.shoppingBGColor = AppLightColors.shoppingBGColor;
      SwitchColors.detailsBoxColor = AppLightColors.detailsBoxColor;
      SwitchColors.cartItemColor = AppLightColors.cartItemColor;
      SwitchColors.itemPriceInAddedToCart =
          AppLightColors.itemPriceInAddedToCart;
      SwitchColors.chickoutAppBarColor = AppLightColors.chickoutAppBarColor;
      SwitchColors.chickoutOrderPlaceColor =
          AppLightColors.chickoutOrderPlaceColor;
      SwitchColors.chickoutDetailsColor = AppLightColors.chickoutDetailsColor;
      SwitchColors.chickoutFillColor = AppLightColors.chickoutFillColor;
      SwitchColors.orderPlaceBGColor = AppLightColors.orderPlaceBGColor;
      SwitchColors.selectedPlaceColor = AppLightColors.selectedPlaceColor;
      SwitchColors.cardFormFieldFillColor =
          AppLightColors.cardFormFieldFillColor;
      SwitchColors.singleItemOrderColor = AppLightColors.singleItemOrderColor;
      SwitchColors.selectedNavColor = AppLightColors.selectedNavColor;
      SwitchColors.favoriteItemsColor = AppLightColors.favoriteItemsColor;
      SwitchColors.discoverButtonColor = AppLightColors.discoverButtonColor;
      SwitchColors.profileBackgroundColor =
          AppLightColors.profileBackgroundColor;
      SwitchColors.profileItemsColor = AppLightColors.profileItemsColor;
      SwitchColors.successfulAppBarColor = AppLightColors.successfulAppBarColor;
      SwitchColors.receiptAppBarColor = AppLightColors.receiptAppBarColor;
      SwitchColors.receiptColor = AppLightColors.receiptColor;
      SwitchColors.dateBoxColor = AppLightColors.dateBoxColor;
      SwitchColors.selectedFilterColor = AppLightColors.selectedFilterColor;
      SwitchColors.otherFiltersColor = AppLightColors.otherFiltersColor;
      SwitchColors.filteredItemColor = AppLightColors.filteredItemColor;
      SwitchColors.dessertsBGCOlor = AppLightColors.dessertsBGCOlor;
      SwitchColors.dessertInfoBoxColor = AppLightColors.dessertInfoBoxColor;
    } else {
      log("Current Theme fom isLight else block $currentTheme"); // Log

      SwitchColors.backgroundMianColor = AppDarkColors.backgroundMianColor;
      SwitchColors.itemBackgoundColor = AppDarkColors.itemBackgoundColor;

      SwitchColors.greenItemColor = AppDarkColors.greenItemColor;
      SwitchColors.quantityButtonColor = AppDarkColors.quantityButtonColor;
      SwitchColors.addToCartBGColor = AppDarkColors.addToCartBGColor;
      SwitchColors.searchFieldFillColor = AppDarkColors.searchFieldFillColor;
      SwitchColors.filterColor = AppDarkColors.filterColor;
      SwitchColors.shoppingBGColor = AppDarkColors.shoppingBGColor;
      SwitchColors.detailsBoxColor = AppDarkColors.detailsBoxColor;
      SwitchColors.cartItemColor = AppDarkColors.cartItemColor;
      SwitchColors.itemPriceInAddedToCart =
          AppDarkColors.itemPriceInAddedToCart;
      SwitchColors.chickoutAppBarColor = AppDarkColors.chickoutAppBarColor;
      SwitchColors.chickoutOrderPlaceColor =
          AppDarkColors.chickoutOrderPlaceColor;
      SwitchColors.chickoutDetailsColor = AppDarkColors.chickoutDetailsColor;
      SwitchColors.chickoutFillColor = AppDarkColors.chickoutFillColor;
      SwitchColors.orderPlaceBGColor = AppDarkColors.orderPlaceBGColor;
      SwitchColors.orderPlaceBGColor = AppDarkColors.orderPlaceBGColor;
      SwitchColors.selectedPlaceColor = AppDarkColors.selectedPlaceColor;
      SwitchColors.cardFormFieldFillColor =
          AppDarkColors.cardFormFieldFillColor;
      SwitchColors.singleItemOrderColor = AppDarkColors.singleItemOrderColor;
      SwitchColors.selectedNavColor = AppDarkColors.selectedNavColor;
      SwitchColors.favoriteItemsColor = AppDarkColors.favoriteItemsColor;
      SwitchColors.discoverButtonColor = AppDarkColors.discoverButtonColor;
      SwitchColors.profileBackgroundColor =
          AppDarkColors.profileBackgroundColor;
      SwitchColors.profileItemsColor = AppDarkColors.profileItemsColor;
      SwitchColors.successfulAppBarColor = AppDarkColors.successfulAppBarColor;
      SwitchColors.receiptAppBarColor = AppDarkColors.receiptAppBarColor;
      SwitchColors.receiptColor = AppDarkColors.receiptColor;
      SwitchColors.dateBoxColor = AppDarkColors.dateBoxColor;
      SwitchColors.selectedFilterColor = AppDarkColors.selectedFilterColor;
      SwitchColors.selectedFilterColor = AppDarkColors.selectedFilterColor;
      SwitchColors.otherFiltersColor = AppDarkColors.otherFiltersColor;
      SwitchColors.filteredItemColor = AppDarkColors.filteredItemColor;
      SwitchColors.filteredItemColor = AppDarkColors.filteredItemColor;
      SwitchColors.filteredItemColor = AppDarkColors.filteredItemColor;
      SwitchColors.dessertsBGCOlor = AppDarkColors.dessertsBGCOlor;
      SwitchColors.dessertInfoBoxColor = AppDarkColors.dessertInfoBoxColor;
    }
    notifyListeners();
  } */
}
 */