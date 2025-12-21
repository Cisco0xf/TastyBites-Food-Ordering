// ignore_for_file: constant_identifier_names

import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/data_layer/data_base/cart_list_database.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_db.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* 

=================== Sync the Locale DB with Firestore ===================


- If there is an opening session right now 

- The user of this session save his data to the cloud database (Firestore)

- This data will also saved in the Locale database for the Fallback system

- If the user signed out then logged in with a new user, the locale database for the old user should be cleared

- So, this is the Flow of the initislization of the locale database
	
	- The locale database will be init from the cloud Firestore
	- The the bool flag saved in the Sharedprefs as initialized 
	- The data will be saved normally in the current user session
	- If the user signed out the local database will be cleared to be ready for the nex session
	
- The bool flage will set as initialized as true after the LOG IN && init the locale DB from cloud DB
- Then will be set as false when the user SIGN OUT and the Locale database is cleared

===========================================================================

*/

class PrefsKeys {
  // Locale to cloud Prefs keys
  static const String CART_PREFS_KEY = "aksfJJONon_mjkf9";
  static const String WISHLIST_PREFS_KEY = "DJNIDifn-_of";
  static const String RECEIPT_PREFS_KEY = "MOddignei09_m";

  // User metadata prefs keys

  static const String USERNAME_KEYS = "MIDNonf-dom_c093";
  static const String USER_BIO_KEY = "NBiegON03_-cmnfnm";

  // App Prefs Keys

  static const String THEME_KEY = "MOND496__mi4t-fmgi0";
}

class SaveSyncPref {
  final String key;

  const SaveSyncPref({required this.key});

  Future<void> saveValueToPref({required bool isInit}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(key, isInit);
  }

  Future<bool> getInitStateFromDb() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool db = prefs.getBool(key) ?? false;

    return db;
  }

  
}

class SyncLocaleWithCloud {
  static Future<void> syncFoodLocaleDBWithFirestore(
    List<FoodModel> data, {
    required String dbKey,
    required String prefKey,
  }) async {
    final ManageCartDB cartDb = ManageCartDB(dbKey);

    final SaveSyncPref sync = SaveSyncPref(key: prefKey);

    final bool isCartInit = await sync.getInitStateFromDb();

    if (!isCartInit) {
      for (int i = 0; i < data.length; i++) {
        await cartDb.addDBItem(data[i]);
      }

      await sync.saveValueToPref(isInit: true);

      Log.log("Food locale Database has been init From Firestore...");
    }
  }

  static Future<void> syncReceiptLocaleDBWithFirestore(
    List<ReceiptModel> data,
  ) async {
    const SaveSyncPref sync = SaveSyncPref(key: PrefsKeys.RECEIPT_PREFS_KEY);

    final bool isReceiptInit = await sync.getInitStateFromDb();

    if (!isReceiptInit) {
      for (int i = 0; i < data.length; i++) {
        await ManageReceiptDB.addNewReceipt(receipt: data[i]);
      }

      await sync.saveValueToPref(isInit: true);

      Log.log("Receipts Locale Database has been init from Firestore...");
    }
  }
}

class SaveMetadata {
  final String prefKey;

  const SaveMetadata({required this.prefKey});

  Future<void> saveMetadata({required String data}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(prefKey, data);
  }

  Future<String> metadataValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String data = prefs.getString(prefKey) ?? "BIO";

    return data;
  }
}
