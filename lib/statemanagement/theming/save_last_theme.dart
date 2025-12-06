import 'dart:developer';

import 'package:foodapp/data_layer/data_base/shared_prefrence/save_last_changes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLastTheme extends SaveLastData {
  static const String themeKey = "theme_key";

  @override
  Future<void> putDataInDatabase({required String putedData}) async {
    SharedPreferences getInstace = await SharedPreferences.getInstance();
    getInstace.setString(themeKey, putedData);
    log("LastTheme : $putedData");
  }

  @override
  Future<String> getDataFromDatabase() async {
    SharedPreferences getInctance = await SharedPreferences.getInstance();
    String theme = getInctance.getString(themeKey) ?? "light";
    return theme;
  }
}
