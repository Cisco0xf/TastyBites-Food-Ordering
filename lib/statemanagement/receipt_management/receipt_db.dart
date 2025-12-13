/* import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/locale_repository.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_model.dart';
import 'package:hive/hive.dart';

abstract class ReceiptHistoryRepository {
  Future<Box> openBox();
  List<ReceiptHistoryModel> getOldReceiptFromDatabase({required Box box});
  Future<void> addNewReceiptToDatabase({
    required Box box,
    required ReceiptHistoryModel newReceipt,
  });
  Future<void> removeReceiptFromDatabse({
    required Box box,
    required ReceiptHistoryModel oldReceipt,
  });
  Future<void> clearDataBase({required Box box});
}

class ReceiptDatabse extends ReceiptHistoryRepository {
  static const String receiptKey = "receipt_key";

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<ReceiptHistoryModel>(receiptKey);
    return box;
  }

  @override
  List<ReceiptHistoryModel> getOldReceiptFromDatabase({
    required Box box,
  }) {
    List<ReceiptHistoryModel> receiptsDatabase =
        box.values.toList() as List<ReceiptHistoryModel>;
    return receiptsDatabase;
  }

  @override
  Future<void> addNewReceiptToDatabase({
    required Box box,
    required ReceiptHistoryModel newReceipt,
  }) async {
    await box.put(
      newReceipt.hashCode,
      newReceipt,
    );
  }

  @override
  Future<void> removeReceiptFromDatabse({
    required Box box,
    required ReceiptHistoryModel oldReceipt,
  }) async {
    await box.delete(oldReceipt.hashCode);
  }

  @override
  Future<void> clearDataBase({required Box box}) async {
    await box.clear();
  }
}
 */