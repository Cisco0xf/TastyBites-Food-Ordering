import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class ReceiptHistoryModel {
  @HiveField(0)
  final String newReceipt;
  @HiveField(1)
  final String dateTime;
  ReceiptHistoryModel({
    required this.newReceipt,
    required this.dateTime,
  });
}
