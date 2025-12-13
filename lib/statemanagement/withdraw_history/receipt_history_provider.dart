// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_db.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/order_single_item/order_single_item_provider.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_model.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_db.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageReceiptHistory extends ChangeNotifier {
  List<ReceiptModel> state = [];

  Future<void> addNewReceipt({bool isSingle = false}) async {
    final ReceiptModel receipt = ReceiptModel(
      newReceipt: isSingle ? singleOrderReceipt() : getRecepit(isHistory: true),
      dateTime: dateTime,
    );

    final bool isExist = state.any((item) => item.id == receipt.id);

    if (isExist) {
      await _removeReceipt(receipt);
      return;
    }

    state = [...state, receipt];

    notifyListeners();

    await ManageReceiptDB.addNewReceipt(receipt: receipt);
  }

  Future<void> _removeReceipt(ReceiptModel receipt) async {
    state = [
      for (int i = 0; i < state.length; i++) ...{
        if (receipt.id != state[i].id) state[i]
      }
    ];

    notifyListeners();

    await ManageReceiptDB.removeReceipt(receipt: receipt);
  }

  Future<void> clearHistory() async {
    state = [];

    await ManageReceiptDB.clearDB();
  }

  void initializeReceiptHistoryFromDatabase(List<ReceiptModel> db) {
    state = db;
  }

  bool get hasData => state.isNotEmpty;

  String get _getRecepitDateTime {
    String recepitDateTime = DateFormat("MMM d, hh:mm aaa").format(
      DateTime.now(),
    );
    return recepitDateTime;
  }

  String get dateTime => _getRecepitDateTime;

  String getRecepit({bool isHistory = false}) {
    final StringBuffer recepit = StringBuffer();

    final BuildContext context = navigationKey.currentContext as BuildContext;

    final CartManager cart = Provider.of<CartManager>(context, listen: false);

    final List<FoodModel> cartItems = cart.state;

    isHistory ? null : recepit.writeln("Ordered in : $_getRecepitDateTime");
    recepit.writeln("Thanks for your order.");
    recepit.writeln("Here's your recepit");
    recepit.writeln("---------------------------------------");
    for (int j = 0; j < cartItems.length; j++) {
      recepit.writeln(
        "${cartItems[j].stock} x ${cartItems[j].foodName} ( \$ ${cartItems[j].foodPrice})",
      );
    }

    recepit.writeln("---------------------------------------");
    recepit.writeln("Total items : ${cartItems.length}");
    recepit.writeln("Discount : \$ ${cart.disCount.toString()}");
    recepit.writeln(cart.serviceOrDelivery());
    recepit.writeln("---------------------------------------");
    recepit.writeln(
      "Total price : \$ ${cart.getOrderTotalArterDiscountAndService()}",
    );
    recepit.writeln("---------------------------------------");

    if (isHistory) {
      recepit.writeln(cart.orderPlace());
    }

    return recepit.toString();
  }

  String singleOrderReceipt() {
    final BuildContext context  = navigationKey.currentContext as BuildContext;

    final SingleItemProvider order =
        Provider.of<SingleItemProvider>(context, listen: false);

        final CartManager cart = Provider.of<CartManager>(context, listen: false);

  final FoodModel orderedItem = order.orderedItem;

    StringBuffer receipt = StringBuffer();
    receipt.writeln("Thanks for your oreder");
    receipt.writeln("Here's your single order receipt");
    receipt.writeln("-" * 30);
    receipt.writeln(
        "${orderedItem.stock} x ${orderedItem.foodName} (\$ ${orderedItem.foodPrice})");
    receipt.writeln("-" * 30);
    receipt.writeln("Quantity : ${orderedItem.stock}");
    receipt.writeln("Offer Discount : ${order.offerDiscout}");
    context.read<PlaceProvider>().isTakeaway
        ? receipt.writeln("Delivery : \$ 11")
        : receipt.writeln("Service : \$ 5");
    receipt.writeln("-" * 30);
    receipt.writeln("Item price : ${order.getTotalPriceAfterDiscountAndService()}");
    receipt.writeln("-" * 30);
    receipt.writeln(cart.orderPlace());

    String orderReceipt = receipt.toString();
    return orderReceipt;
  }
}
/* 
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
 */