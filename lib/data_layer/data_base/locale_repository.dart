/* import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:hive/hive.dart';

abstract class GlobalLocaleRepository {
  Future<Box> openBox();
  List<T> getDataFromBox({
    required Box box,
  });
  Future<void> putItemInBox({
    required Box box,
    required T item,
  });

  Future<void> removeItemFromBox({
    required Box box,
    required T item,
  });
  Future<void> clearBox({required Box box});
}
 */

import 'package:hive/hive.dart';

abstract class Database<T> {
  Future<Box> get openBox;

  List<T> getFoodDtaFromDatabase({required Box box});

  Future<void> addItemToDB({required Box box, required T food});
  Future<void> removeItemFromDB({required Box box, required T food});

  Future<void> clearDB({required Box box});
}
