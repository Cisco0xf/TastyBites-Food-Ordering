import 'package:hive/hive.dart';

part 'receipt_model.g.dart';

@HiveType(typeId: 1)
class ReceiptModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String newReceipt;
  @HiveField(2)
  final String dateTime;
  ReceiptModel({
    required this.newReceipt,
    required this.dateTime,
    required this.id,
  }) ;

  Map<String, dynamic> fromModel(ReceiptModel receipt) {
    return {
      "id": receipt.id,
      "receipt": receipt.newReceipt,
      "dateTime": receipt.dateTime,
    };
  }

  factory ReceiptModel.fromSnapshot({required Map<String, dynamic> snapshots}) {
    return ReceiptModel(
      newReceipt: snapshots["newReceipt"] as String,
      dateTime: snapshots["dateTime"] as String,
      id: snapshots["id"] as String,
    );
  }
}
