/* import 'package:foodapp/data_layer/data_base/locale_repository.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:hive/hive.dart';

class WishListDataBase extends GlobalLocaleRepository {
  static const String wishListBox = "wish_list_box";

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<FoodModel>(wishListBox);
    return box;
  }

  @override
  List<FoodModel> getDataFromBox({
    required Box box,
  }) {
    List<FoodModel> wishListData = box.values.toList() as List<FoodModel>;
    return wishListData;
  }

  @override
  Future<void> putItemInBox({
    required Box box,
    required FoodModel item,
  }) async {
    await box.put(
      item.foodName.toString(),
      item,
    );
  }

  @override
  Future<void> removeItemFromBox({
    required Box box,
    required FoodModel item,
  }) async {
    await box.delete(item.foodName.toString());
  }

  @override
  Future<void> clearBox({required Box box}) async {
    await box.clear();
  }
}
 */