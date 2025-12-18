import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/constants/texts.dart';
import 'package:foodapp/data_layer/data_base/cart_list_database.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/hive_keys.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/statemanagement/cloud_firestore/collections.dart';
import 'package:toastification/toastification.dart';

class WishListProvider with ChangeNotifier {
  List<FoodModel> favoriteItems = [];

  bool isLoading = false;

  void _switchLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  // Manage Firestore WishList

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  CollectionReference get _wishListCollection {
    final String userId = _auth.currentUser!.uid;

    final CollectionReference wishList = _fireStore
        .collection(Collections.USER_COLLECTION)
        .doc(userId)
        .collection(Collections.WISHLIST_COLLECTION);

    return wishList;
  }

  Future<void> addItemToFirestoreWishList(FoodModel item) async {
    final bool isExistInLocale =
        favoriteItems.any((food) => food.id == item.id);
    if (isExistInLocale) {
      await removeItemFromFirestoreWishList(item);
      return;
    }

    _switchLoadingState();

    try {
      await _wishListCollection.doc(item.id).set(item.fromModel(item: item));

      await addItemToFavorite(item: item);

      showToastification(
        message: addedFavorite,
        type: ToastificationType.success,
      );
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FIrebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("WishList Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
      _switchLoadingState();
    }
  }

  Future<void> removeItemFromFirestoreWishList(FoodModel item) async {
    _switchLoadingState();

    try {
      await _wishListCollection.doc(item.id).delete();

      await removeItemFromFavorite(item: item);

      showToastification(
        message: removedFavorite,
        type: ToastificationType.success,
      );
    } on SocketException {
      showToastification(message: internet, type: ToastificationType.error);
    } on FirebaseException catch (error) {
      Log.error("FirebaseException => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } catch (error) {
      Log.error("WishList Action Error => $error");
      showToastification(message: someError, type: ToastificationType.error);
    } finally {
      _switchLoadingState();
    }
  }

  // Manage Locale Database Wishlish

  final ManageCartDB _wishList = ManageCartDB(HiveKeys.WISH_LIST_KEY);

  Future<void> addItemToFavorite({
    required FoodModel item,
  }) async {
    favoriteItems = [...favoriteItems, item];

    notifyListeners();

    await _wishList.addDBItem(item);
  }

  Future<void> removeItemFromFavorite({required FoodModel item}) async {
    favoriteItems = [
      for (int i = 0; i < favoriteItems.length; i++) ...{
        if (favoriteItems[i].id != item.id) favoriteItems[i]
      }
    ];

    notifyListeners();

    await _wishList.removeDBItem(item);

    // await ManageFirestore().removeItemFromWhishList(item);
  }

/* 
  void initializeWishListFromDatabase(List<FoodModel> db) {
    favoriteItems = [...db];
  } */

  // Data initialization'

  Future<void> _initWishlistFromLocaleDB() async {
    try {
      final List<FoodModel> db = await _wishList.retrivedDataFromDB();

      favoriteItems = db;
    } catch (error) {
      Log.error("Error init Wishlist from Locale DB => $error");
    }
  }

  Future<void> initializeWishList() async {
    try {
      final QuerySnapshot wishListQuery = await _wishListCollection.get();

      final List<QueryDocumentSnapshot> wishListData = wishListQuery.docs;

      List<FoodModel> wishListItems = [];

      for (int i = 0; i < wishListData.length; i++) {
        final Map<String, dynamic> item =
            wishListData[i].data() as Map<String, dynamic>;

        final FoodModel foodItem = FoodModel.fromSnapshots(snapshot: item);

        wishListItems.add(foodItem);
      }

      favoriteItems = wishListItems;

      Log.log("WishList has been retrived from Firestore successfully");
    } on SocketException {
      await _initWishlistFromLocaleDB();
    } on FirebaseException catch (error) {
      Log.error("FirebaseException => $error");
      await _initWishlistFromLocaleDB();
    } catch (error) {
      Log.error("WishList Action Error => $error");
      await _initWishlistFromLocaleDB();
    }
  }
}
