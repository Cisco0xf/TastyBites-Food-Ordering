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
  }) : id = DateTime.now().toIso8601String();

  Map<String, dynamic> fromModel(ReceiptModel receipt) {
    return {
      "id": receipt.id,
      "receipt": receipt.newReceipt,
      "dateTime": receipt.dateTime,
    };
  }
}
