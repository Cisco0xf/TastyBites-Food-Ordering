/* import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:hive/hive.dart';

abstract class GlobalLocaleRepository {
  Future<Box> openBox();
  List<FoodModel> getDataFromBox({
    required Box box,
  });
  Future<void> putItemInBox({
    required Box box,
    required FoodModel item,
  });

  Future<void> removeItemFromBox({
    required Box box,
    required FoodModel item,
  });
  Future<void> clearBox({required Box box});
}
 */

import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:hive/hive.dart';

abstract interface class Database {
  Future<Box> get openBox;

  List<FoodModel> getFoodDtaFromDatabase({required Box box});

  Future<void> addItemToDB({required Box box, required FoodModel food});
  Future<void> removeItemFromDB({required Box box, required FoodModel food});

  Future<void> clearDB({required Box box});
}
