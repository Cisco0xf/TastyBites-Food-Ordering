import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/data_layer/data_base/cart_list_database.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/hive_keys.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/cloud_firestore/collections.dart';
import 'package:foodapp/statemanagement/cloud_firestore/sync_locale_with_cloud.dart';
import 'package:foodapp/statemanagement/user_address/get_user_address.dart';
import 'package:foodapp/statemanagement/user_table/get_user_table.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CartManager extends ChangeNotifier {
  List<FoodModel> state = [];

  final BuildContext context;

  CartManager(this.context);

  // Manage the Firestore Cart Database

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _cartCollection {
    final String user = _auth.currentUser!.uid;

    final CollectionReference cart = _firestore
        .collection(Collections.USER_COLLECTION)
        .doc(user)
        .collection(Collections.CART_COLLECTION);

    return cart;
  }

  bool isOperating = false;

  void _switchLoadingState() {
    isOperating = !isOperating;
    notifyListeners();
  }

  Future<void> addFoodItemToFirestoreCart(FoodModel target) async {
    final bool isExistInLocale = state.any((item) => target.id == item.id);

    if (isExistInLocale) {
      await removeFoodItemFromFirestoreCart(target);

      return;
    }

    _switchLoadingState();

    try {
      await _cartCollection.doc(target.id).set(target.fromModel(item: target));

      await addFoodItemToCart(target);

      showToastification(message: addedCart, type: ToastificationType.success);

      Log.log("${target.foodName} has been added to Firestore");
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FIrebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("Cart Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
      _switchLoadingState();
    }
  }

  Future<void> removeFoodItemFromFirestoreCart(FoodModel target) async {
    _switchLoadingState();
    try {
      await _cartCollection.doc(target.id).delete();

      await removeItemFromCart(target);

      showToastification(
        message: removedCart,
        type: ToastificationType.success,
      );

      Log.log("${target.foodName} has been removed from Firestore");
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FIrebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("Cart Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
      _switchLoadingState();
    }
  }

  Future<void> clearFirestoreCart() async {
    _switchLoadingState();
    try {
      final QuerySnapshot cartQuery = await _cartCollection.get();

      final List<QueryDocumentSnapshot> cartData = cartQuery.docs;

      final WriteBatch batch = _firestore.batch();

      for (int i = 0; i < cartData.length; i++) {
        batch.delete(cartData[i].reference);
      }

      await batch.commit();

      await clearCart();

      Log.log("Cart Collection has been deleted successfully...");
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FIrebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("Cart Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
      _switchLoadingState();
    }
  }

  // Manage the Cart Locale Database

  final ManageCartDB cartDb = ManageCartDB(HiveKeys.CART_KEY);

  Future<void> addFoodItemToCart(FoodModel food) async {
    state = [...state, food];
    notifyListeners();

    await cartDb.addDBItem(food);
  }

  Future<void> removeItemFromCart(FoodModel food) async {
    state = [
      for (int i = 0; i < state.length; i++) ...{
        if (state[i].id != food.id) state[i],
      }
    ];

    notifyListeners();

    await cartDb.removeDBItem(food);
  }

  Future<void> clearCart() async {
    state = [];

    notifyListeners();

    context.read<TableProvider>().clearTable();
    context.read<AddressProvider>().clearAddress();

    await cartDb.clearDb();

    // Firestore cart

    // await ManageUserMetadata().clearFirestoreCart();
  }

  void increaseQnt(FoodModel food) {
    state = [
      for (int i = 0; i < state.length; i++) ...{
        if (food.id == state[i].id)
          state[i].copyWith(stock: state[i].stock + 1)
        else
          state[i]
      }
    ];

    notifyListeners();
  }

  void decreaseQnt(FoodModel food) {
    for (int i = 0; i < state.length; i++) {
      final bool isSushi = state[i].foodType == "Sushi";

      final bool isTarget = state[i].id == food.id;

      if (isSushi && isTarget) {
        final bool sushiStok = state[i].stock > 5;
        if (sushiStok) {
          state[i].copyWith(stock: state[i].stock - 1);
        } else {
          showToastification(
            message: "Sush Quantity must be >= 5",
          );
        }
      }

      if (isTarget && state[i].stock > 0) {
        state[i].copyWith(stock: state[i].stock - 1);
      }
    }

    notifyListeners();
  }

  String get selectedTable => context.read<TableProvider>().selectedTable;
  String get userAddress => context.read<AddressProvider>().userAddress;
  bool get isTakeaway => context.read<PlaceProvider>().isTakeaway;

  double get getTotlaPrice {
    double total = 0;

    for (int i = 0; i < state.length; i++) {
      if (state[i].foodType == "Sushi") {
        total += state[i].foodPrice * state[i].stock / 5;
      } else {
        total += state[i].foodPrice * state[i].stock;
      }
    }
    total = double.parse(total.toStringAsFixed(2)).toDouble();
    return total;
  }

  double get disCount {
    double disCount = 0;
    if (getTotlaPrice < 25.0 && getTotlaPrice > 0) {
      disCount = 0;
    } else if (getTotlaPrice > 25.0 && getTotlaPrice < 50.0) {
      disCount = 10.99;
    } else if (getTotlaPrice > 50.0 && getTotlaPrice < 150.0) {
      disCount = 20.0;
    } else {
      disCount = 50.0;
    }
    return disCount;
  }

  double get orderTotlAfterDiscount {
    double orderTotal = getTotlaPrice - disCount;

    orderTotal = double.parse(orderTotal.toStringAsFixed(2)).toDouble();
    return orderTotal;
  }

  double getOrderTotalArterDiscountAndService() {
    double orderTotal = 0;

    if (isTakeaway) {
      orderTotal = orderTotlAfterDiscount + 11;
    } else {
      orderTotal = orderTotlAfterDiscount + 5;
    }

    return double.parse(orderTotal.toStringAsFixed(2));
  }

  // Chick the user choice

  String orderPlace() {
    if (isTakeaway) {
      return ("Delivered to $userAddress");
    }
    return ("Ordered at the restaurant, table $selectedTable");
  }

  String serviceOrDelivery() {
    if (isTakeaway) {
      return "Delivery : \$ 11";
    }
    return "Service : \$ 5";
  }

  // Data Ininitializer

  Future<void> _loacleCartDatabase() async {
    try {
      final List<FoodModel> localeCashe = await cartDb.retrivedDataFromDB();

      state = localeCashe;
    } catch (error) {
      Log.error("Error while Inin Cart From Local Cash => $error");
    }
  }

  Future<void> initializeCart() async {
    try {
      final QuerySnapshot cartQuery = await _cartCollection.get();

      final List<QueryDocumentSnapshot> cartDocs = cartQuery.docs;

      List<FoodModel> cartData = [];

      for (int i = 0; i < cartDocs.length; i++) {
        final Map<String, dynamic> foodItem =
            cartDocs[i].data() as Map<String, dynamic>;

        final FoodModel target = FoodModel.fromSnapshots(snapshot: foodItem);

        cartData.add(target);
      }

      state = cartData;

      await SyncLocaleWithCloud.syncFoodLocaleDBWithFirestore(
        cartData,
        dbKey: HiveKeys.CART_KEY,
        prefKey: PrefsKeys.CART_PREFS_KEY,
      );

      Log.log("Data has been retrived from the Firestore DB");
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
      await _loacleCartDatabase();
    } on FirebaseException catch (error) {
      Log.error("FIrebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
      await _loacleCartDatabase();
    } catch (error) {
      Log.error("Getting Cart Data Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
      await _loacleCartDatabase();
    }
  }
}
