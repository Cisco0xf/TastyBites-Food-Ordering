// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/statemanagement/withdraw_history/data_model.dart';
import 'package:foodapp/statemanagement/withdraw_history/databse.dart';
import 'package:hive/hive.dart';

class ReceiptHistoryProvider with ChangeNotifier {
  // Get instance from database class
  final ReceiptDatabse _receiptDatabse = ReceiptDatabse();
  ReceiptDatabse get receiptDatabase => _receiptDatabse;
  // Add receipt to the history
  List<ReceiptHistoryModel> receiptHistoryList = <ReceiptHistoryModel>[];
  Future<void> addNewReceipt({
    required BuildContext context,
    required ReceiptHistoryModel receipt,
  }) async {
    // Add newReceipt to list

    receiptHistoryList.add(
      receipt,
    );
    // Add new receipt to database

    Box box = await receiptDatabase.openBox();

    receiptDatabase.addNewReceiptToDatabase(
      box: box,
      newReceipt: receipt,
    );

    notifyListeners();
  }

  // Clear receipt history list && receipt database

  Future<void> get clearReceiptHistory async {
    Box box = await receiptDatabase.openBox();
    receiptHistoryList.clear();
    receiptDatabase.clearDataBase(box: box);
    notifyListeners();
  }

  // Initailize the database when the app starts

  Future<void> get intializeDatabse async {
    Box box = await receiptDatabase.openBox();

    List<ReceiptHistoryModel> initailReceipt =
        receiptDatabase.getOldReceiptFromDatabase(box: box);

    receiptHistoryList = initailReceipt;
    notifyListeners();
  }

  ReceiptHistoryProvider() {
    intializeDatabse;
  }

  // Wait to loadding

  bool isLoadding = true;

  Future<void> get waitToLoadding async {
    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        isLoadding = false;
        notifyListeners();
      },
    );
  }
}
