import 'package:flutter/material.dart';
import 'package:foodapp/data_layer/data_base/cart_list_database.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/hive_keys.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
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
    ReusableMethods.showtoastification(
      message: "Item added to favorite",
      type: ToastificationType.success,
    );

    notifyListeners();

    await _wishList.addDBItem(item);
  }

  Future<void> removeItemFromFavorite({required FoodModel item}) async {
    favoriteItems = [
      for (int i = 0; i < favoriteItems.length; i++) ...{
        if (favoriteItems[i].id != item.id) favoriteItems[i]
      }
    ];
    ReusableMethods.showtoastification(
      message: "Item removed from favorite",
    );

    notifyListeners();

    await _wishList.removeDBItem(item);
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
