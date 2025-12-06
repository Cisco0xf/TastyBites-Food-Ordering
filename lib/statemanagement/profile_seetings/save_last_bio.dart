import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLastBio {
  static const String bioKey = "bio_key";

  Future<void> putDataInDatabase({required String putedData}) async {
    final SharedPreferences getData = await SharedPreferences.getInstance();
    await getData.setString(bioKey, putedData);
  }

  Future<String> getDataFromDatabase() async {
    String currentUserName =
        FirebaseAuth.instance.currentUser!.displayName as String;
    SharedPreferences getBioData = await SharedPreferences.getInstance();
    String userBio =
        getBioData.getString(bioKey) ?? "Hello my name is $currentUserName";

    return userBio;
  }
}
