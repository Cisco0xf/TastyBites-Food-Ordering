import 'package:foodapp/data_layer/data_base/shared_prefrence/save_last_changes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLastLanguage extends SaveLastData {
  static const String localizationKey = "locale_key";

  @override
  Future<void> putDataInDatabase({required String putedData}) async {
    SharedPreferences getInctence = await SharedPreferences.getInstance();

    await getInctence.setString(localizationKey, putedData);
  }

  @override
  Future<String> getDataFromDatabase() async {
    SharedPreferences getInstance = await SharedPreferences.getInstance();

    String lastLocale = getInstance.getString(localizationKey) ?? "en";

    return lastLocale;
  }
}
