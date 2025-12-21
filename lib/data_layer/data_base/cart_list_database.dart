import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/locale_repository.dart';
import 'package:hive/hive.dart';

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
}

enum InitType {
  cart,
  wish,
  none,
}
