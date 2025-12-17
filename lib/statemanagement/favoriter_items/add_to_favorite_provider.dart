import 'package:flutter/material.dart';
import 'package:foodapp/data_layer/data_base/cart_list_database.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/hive_keys.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/statemanagement/cloud_firestore/manage_firestore.dart';
import 'package:toastification/toastification.dart';

class WishListProvider with ChangeNotifier {
  List<FoodModel> favoriteItems = [];

  final ManageCartDB _wishList = ManageCartDB(HiveKeys.WISH_LIST_KEY);

  Future<void> addItemToFavorite({
    required FoodModel item,
  }) async {
    final bool isExist = favoriteItems.any((ele) => item.id == ele.id);
    if (isExist) {
      await removeItemFromFavorite(item: item);

      return;
    }

    favoriteItems = [...favoriteItems, item];
    showToastification(
      message: "Item added to favorite",
      type: ToastificationType.success,
    );

    notifyListeners();

    await _wishList.addDBItem(item);

    await ManageFirestore().addNewItemToWishlist(item);
  }

  Future<void> removeItemFromFavorite({required FoodModel item}) async {
    favoriteItems = [
      for (int i = 0; i < favoriteItems.length; i++) ...{
        if (favoriteItems[i].id != item.id) favoriteItems[i]
      }
    ];
    showToastification(
      message: "Item removed from favorite",
    );

    notifyListeners();

    await _wishList.removeDBItem(item);

     await ManageFirestore().removeItemFromWhishList(item);
  }

  Future<void> clearFavorite() async {
    favoriteItems = [];

    await _wishList.clearDb();
    notifyListeners();
  }

  void initializeWishListFromDatabase(List<FoodModel> db) {
    favoriteItems = [...db];
  }
}
