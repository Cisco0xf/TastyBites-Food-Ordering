// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_db.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/cloud_firestore/collections.dart';
import 'package:foodapp/statemanagement/cloud_firestore/sync_locale_with_cloud.dart';
import 'package:foodapp/statemanagement/order_single_item/order_single_item_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ManageReceiptHistory extends ChangeNotifier {
  List<ReceiptModel> state = [];

  bool isLoading = false;

  void _switchLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  // Manage Receipt Database on Fierstore

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _receiptsColltion {
    final String userId = _auth.currentUser!.uid;

    final CollectionReference receipts = _firestore
        .collection(Collections.USER_COLLECTION)
        .doc(userId)
        .collection(Collections.RECEIPTS_COLLECTION);

    return receipts;
  }

  Future<void> addNewReceiptToFirestore({bool isSingle = false}) async {
    final ReceiptModel receipt = _generatedReciept(isSingle);

    final bool isExistInLocale = state.any((test) => test.id == receipt.id);

    if (isExistInLocale) {
      await removeReceiptFromFirestore(receipt);
      return;
    }

    _switchLoading();
    try {
      await _receiptsColltion.doc(receipt.id).set(receipt.fromModel(receipt));

      await addNewReceipt();

      Log.log("Receipt has been added to Firestore");
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FIrebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("Receipt Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
      _switchLoading();
    }
  }

  Future<void> removeReceiptFromFirestore(ReceiptModel receipt) async {
    _switchLoading();
    try {
      await _receiptsColltion.doc(receipt.id).delete();

      await _removeReceipt(receipt);

      Log.log("Receipt has been removed from Firestore");
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FirebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("Receipt Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
      _switchLoading();
    }
  }

  Future<void> clearReceiptsFirestoreDB() async {
    _switchLoading();
    try {
      final QuerySnapshot receiptsQuery = await _receiptsColltion.get();

      final List<QueryDocumentSnapshot> receiptsData = receiptsQuery.docs;

      final WriteBatch batch = _firestore.batch();

      for (int i = 0; i < receiptsData.length; i++) {
        batch.delete(receiptsData[i].reference);
      }

      await batch.commit();

      await clearHistory();

      Log.log("Receipts Firestore DB has been deleted...");
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FirebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("Receipt Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
      _switchLoading();
    }
  }

  ReceiptModel _generatedReciept(bool isSingle) {
    final ReceiptModel receipt = ReceiptModel(
      newReceipt: isSingle ? singleOrderReceipt() : getRecepit(isHistory: true),
      id: DateTime.now().toIso8601String(),
      dateTime: dateTime,
    );

    return receipt;
  }

  // Manage Receipts Locale Database

  Future<void> addNewReceipt({bool isSingle = false}) async {
    final ReceiptModel receipt = _generatedReciept(isSingle);

    state = [...state, receipt];

    // notifyListeners();

    await ManageReceiptDB.addNewReceipt(receipt: receipt);

    // await ManageUserMetadata().addNewReceuptToFirestore(receipt: receipt);
  }

  Future<void> _removeReceipt(ReceiptModel receipt) async {
    state = [
      for (int i = 0; i < state.length; i++) ...{
        if (receipt.id != state[i].id) state[i]
      }
    ];

    await ManageReceiptDB.removeReceipt(receipt: receipt);

    // await ManageUserMetadata().removeReceiptFromFirestore(receipt);
  }

  Future<void> clearHistory() async {
    state = [];

    notifyListeners();

    await ManageReceiptDB.clearDB();

    //await ManageUserMetadata().clearReceiptFirestore();
  }
/* 
  void initializeReceiptHistoryFromDatabase(List<ReceiptModel> db) {
    state = db;
  }
 */
  // Generate the Receipt Frormat for User

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
    final BuildContext context = navigationKey.currentContext as BuildContext;

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
    receipt.writeln(
        "Item price : ${order.getTotalPriceAfterDiscountAndService()}");
    receipt.writeln("-" * 30);
    receipt.writeln(cart.orderPlace());

    String orderReceipt = receipt.toString();
    return orderReceipt;
  }

  // Initialize Receipts Item from the Firestore || Database

  Future<void> _localeDbReceipts() async {
    try {
      final List<ReceiptModel> db =
          await ManageReceiptDB.receiptFromLocaleDatabase();

      state = db;
    } catch (error) {
      Log.error("Init Receipt DB Error => $error");
    }
  }

  Future<void> initializeReceipts() async {
    try {
      final QuerySnapshot receiptsQuery = await _receiptsColltion.get();

      final List<QueryDocumentSnapshot> receiptsDocs = receiptsQuery.docs;

      List<ReceiptModel> cloudReceipts = [];

      for (int i = 0; i < receiptsDocs.length; i++) {
        final Map<String, dynamic> receiptMap =
            receiptsDocs[i].data() as Map<String, dynamic>;

        final ReceiptModel receipt = ReceiptModel.fromSnapshot(
          snapshots: receiptMap,
        );

        cloudReceipts.add(receipt);
      }

      state = cloudReceipts;

      await SyncLocaleWithCloud.syncReceiptLocaleDBWithFirestore(cloudReceipts);

      Log.log("Receipt Database has been init From the Firestore Successfully");
    } on SocketException {
      await _localeDbReceipts();
    } on FirebaseException catch (error) {
      Log.error("FirebaseException => $error");
      await _localeDbReceipts();
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("Receipt Action Error => $error");
      await _localeDbReceipts();
      showToastification(message: someError, type: ToastificationType.error);
    }
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