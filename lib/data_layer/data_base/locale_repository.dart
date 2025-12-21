
import 'package:hive/hive.dart';

abstract class Database<T> {
  Future<Box> get openBox;

  List<T> getFoodDtaFromDatabase({required Box box});

  Future<void> addItemToDB({required Box box, required T food});
  Future<void> removeItemFromDB({required Box box, required T food});

  Future<void> clearDB({required Box box});
}
