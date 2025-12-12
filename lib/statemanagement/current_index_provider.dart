import 'package:flutter/material.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/data_layer/data_base/cart_list_database.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:provider/provider.dart';

class CurrentIndexProvider with ChangeNotifier {
  // Change the index of the showen categories
  int currentIndex = 0;

  void getNewIndex({required int newIndex}) {
    currentIndex = newIndex;

    notifyListeners();
  }

  // Change the index of the bottom app bar

  int currentContent = 0;

  void switchContent(int target) {
    currentContent = target;
    notifyListeners();
  }

  // Drinks INdex

  int drinkIndex = 0;

  void selectDrinsType(int type) {
    drinkIndex = type;
    final BuildContext context = navigationKey.currentContext as BuildContext;

    context.read<SearchingProvider>().filtesearchWithFilterCategoriesItems();
    notifyListeners();
  }
}
