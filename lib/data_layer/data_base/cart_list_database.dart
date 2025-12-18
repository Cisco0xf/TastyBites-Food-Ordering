/* import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/locale_repository.dart';
import 'package:hive/hive.dart';

class CartListDataBase extends GlobalLocaleRepository {
  static const String cartBoxName = "cart_box";
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<FoodModel>(cartBoxName);
    return box;
  }

  @override
  List<FoodModel> getDataFromBox({required Box box}) {
    List<FoodModel> cartList = box.values.toList() as List<FoodModel>;
    return cartList;
  }

  @override
  Future<void> putItemInBox({
    required Box box,
    required FoodModel item,
  }) async {
    await box.put(
      "${item.foodName}${item.foodPrice}",
      item,
    );
  }

  @override
  Future<void> removeItemFromBox({
    required Box box,
    required FoodModel item,
  }) async {
    await box.delete(
      "${item.foodName}${item.foodPrice}",
    );
  }

  @override
  Future<void> clearBox({required Box box}) async {
    await box.clear();
  }
}
 */

import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/hive_keys.dart';
import 'package:foodapp/data_layer/data_base/locale_repository.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_db.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CartDatabase implements Database<FoodModel> {
  final String dbKey;

  CartDatabase(this.dbKey);

  @override
  Future<Box> get openBox async {
    final Box box = await Hive.openBox<FoodModel>(dbKey);

    return box;
  }

  @override
  List<FoodModel> getFoodDtaFromDatabase({required Box box}) {
    final List<FoodModel> db = box.values.toList() as List<FoodModel>;

    return db;
  }

  @override
  Future<void> addItemToDB({required Box box, required FoodModel food}) async {
    await box.put(food.id, food);
  }

  @override
  Future<void> removeItemFromDB(
      {required Box box, required FoodModel food}) async {
    await box.delete(food.id);
  }

  @override
  Future<void> clearDB({required Box box}) async {
    await box.clear();
  }
}

class ManageCartDB {
  final String dbKey;

  ManageCartDB(this.dbKey);

  Database<FoodModel> get _cartDB => CartDatabase(dbKey);

  Future<void> addDBItem(FoodModel food) async {
    final Box box = await _cartDB.openBox;

    try {
      await _cartDB.addItemToDB(box: box, food: food);
    } catch (error) {
      Log.error("Error Adding CartDb => $error");
    }
  }

  Future<void> removeDBItem(FoodModel food) async {
    final Box box = await _cartDB.openBox;

    try {
      await _cartDB.removeItemFromDB(box: box, food: food.copyWith());
    } catch (error) {
      Log.error("Error Db remove => $error");
    }
  }

  Future<void> clearDb() async {
    final Box box = await _cartDB.openBox;

    try {
      await _cartDB.clearDB(box: box);
    } catch (error) {
      Log.error("Erro clearing => $error");
    }
  }

  Future<List<FoodModel>> retrivedDataFromDB() async {
    final Box box = await _cartDB.openBox;

    final List<FoodModel> db = _cartDB.getFoodDtaFromDatabase(box: box);

    return db;
  }

  Future<void> initializeDataFromDB({
    InitType type = InitType.cart,
  }) async {
    final Box box = await _cartDB.openBox;
    final List<FoodModel> db = _cartDB.getFoodDtaFromDatabase(box: box);

    final bool initCart = type == InitType.cart;

    /* if (initCart) {
      Provider.of<CartManager>(navigationKey.currentContext!, listen: false)
          .initializeCartFromDatabase(db);

      return;
    } */

    /* Provider.of<WishListProvider>(navigationKey.currentContext!, listen: false)
        .initializeWishListFromDatabase(db); */
  }
}

class InitDB {
  static Future<void> initDB() async {
    final ManageCartDB cartDb = ManageCartDB(HiveKeys.CART_KEY);
    await cartDb.initializeDataFromDB();

    Log.log("Cart DB has been init successfully...");

    final ManageCartDB wishList = ManageCartDB(HiveKeys.WISH_LIST_KEY);
    await wishList.initializeDataFromDB(type: InitType.wish);

    Log.log("WishList DB has been init successfully...");

    await ManageReceiptDB.initializeReceiptHistoryFromDatabase();

    Log.log("Receipt DB has been init Successfully...");
  }
}

enum InitType {
  cart,
  wish,
  none,
}
