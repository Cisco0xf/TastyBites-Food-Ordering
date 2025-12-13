import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/data_layer/data_base/hive_keys.dart';
import 'package:foodapp/data_layer/data_base/locale_repository.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/statemanagement/receipt_management/receipt_history_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ReceiptDB extends Database<ReceiptModel> {
  @override
  Future<Box> get openBox async {
    final Box box = await Hive.openBox<ReceiptModel>(
      HiveKeys.RECEIPT_HISTORY_KEY,
    );

    return box;
  }

  @override
  List<ReceiptModel> getFoodDtaFromDatabase({required Box box}) {
    final List<ReceiptModel> history =
        box.values.toList() as List<ReceiptModel>;

    return history;
  }

  @override
  Future<void> addItemToDB({
    required Box box,
    required ReceiptModel food,
  }) async {
    await box.put(food.id, food);
  }

  @override
  Future<void> removeItemFromDB({
    required Box box,
    required ReceiptModel food,
  }) async {
    await box.delete(food.id);
  }

  @override
  Future<void> clearDB({required Box box}) async {
    await box.clear();
  }
}

class ManageReceiptDB {
  static final ReceiptDB _receiptDB = ReceiptDB();

  static Future<void> addNewReceipt({required ReceiptModel receipt}) async {
    final Box box = await _receiptDB.openBox;

    try {
      await _receiptDB.addItemToDB(box: box, food: receipt);
    } catch (error) {
      Log.error("DB Adding Receipt Error => $error");
    }
  }

  static Future<void> removeReceipt({required ReceiptModel receipt}) async {
    final Box box = await _receiptDB.openBox;

    try {
      await _receiptDB.removeItemFromDB(box: box, food: receipt);
    } catch (error) {
      Log.error("DB Removeing Receipt Error => $error");
    }
  }

  static Future<void> clearDB() async {
    final Box box = await _receiptDB.openBox;

    await _receiptDB.clearDB(box: box);
  }

  static Future<void> initializeReceiptHistoryFromDatabase() async {
    final Box box = await _receiptDB.openBox;

    final List<ReceiptModel> db = _receiptDB.getFoodDtaFromDatabase(box: box);

    Provider.of<ManageReceiptHistory>(
      navigationKey.currentContext!,
      listen: false,
    ).initializeReceiptHistoryFromDatabase(db);
  }
}
