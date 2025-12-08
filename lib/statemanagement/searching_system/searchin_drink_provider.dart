import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/drinks_cold_demo_data.dart';
import 'package:foodapp/data_layer/data_models/drinks_hot_demo_data.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/price_filter_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/ratting_provider.dart';
import 'package:foodapp/statemanagement/searching_system/controllers_manager.dart';
import 'package:provider/provider.dart';

class SearchingDrinksProvider with ChangeNotifier {
  late List<FoodModel> drinkList;

  final TextEditingController _searchingDrinkController =
      TextEditingController();

  TextEditingController get searchingDrinkController =>
      _searchingDrinkController;

  List<FoodModel> filteredDrinks = [];

  void filterDrinke({required BuildContext context}) {
    PriceFilterProvider priceFilter = Provider.of<PriceFilterProvider>(
      context,
      listen: false,
    );
    RattingProvider ratting = Provider.of<RattingProvider>(
      context,
      listen: false,
    );
    filteredDrinks = List.from(drinkList);

    if (ratting.isAny) {
      if (priceFilter.isAll) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return searchinedDrink.foodName.toLowerCase().contains(
                  searchingDrinkController.text.toLowerCase(),
                );
          },
        ).toList();
      } else if (priceFilter.isCheap) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodPrice >= 5) &&
                (searchinedDrink.foodPrice <= 20) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else if (priceFilter.isMedium) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodPrice >= 21) &&
                (searchinedDrink.foodPrice <= 50) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodPrice >= 51) &&
                (searchinedDrink.foodPrice <= 120) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      }
    } else if (ratting.isGood) {
      if (priceFilter.isAll) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodRate >= 2.0) &&
                (searchinedDrink.foodRate <= 3.3) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else if (priceFilter.isCheap) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodRate >= 2.0) &&
                (searchinedDrink.foodRate <= 3.3) &&
                (searchinedDrink.foodPrice >= 5) &&
                (searchinedDrink.foodPrice <= 20) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else if (priceFilter.isMedium) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodRate >= 2.0) &&
                (searchinedDrink.foodRate <= 3.3) &&
                (searchinedDrink.foodPrice >= 21) &&
                (searchinedDrink.foodPrice <= 50) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodRate >= 2.0) &&
                (searchinedDrink.foodRate <= 3.3) &&
                (searchinedDrink.foodPrice >= 51) &&
                (searchinedDrink.foodPrice <= 120) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      }
    } else {
      if (priceFilter.isAll) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodRate >= 3.3) &&
                (searchinedDrink.foodRate <= 5.0) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else if (priceFilter.isCheap) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodRate >= 3.3) &&
                (searchinedDrink.foodRate <= 5.0) &&
                (searchinedDrink.foodPrice >= 5) &&
                (searchinedDrink.foodPrice <= 20) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else if (priceFilter.isMedium) {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodRate >= 3.3) &&
                (searchinedDrink.foodRate <= 5.0) &&
                (searchinedDrink.foodPrice >= 21) &&
                (searchinedDrink.foodPrice <= 50) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else {
        filteredDrinks = drinkList.where(
          (searchinedDrink) {
            return (searchinedDrink.foodRate >= 3.3) &&
                (searchinedDrink.foodRate <= 5.0) &&
                (searchinedDrink.foodPrice >= 51) &&
                (searchinedDrink.foodPrice <= 120) &&
                searchinedDrink.foodName.toLowerCase().contains(
                      searchingDrinkController.text.toLowerCase(),
                    );
          },
        ).toList();
      }
    }

    notifyListeners();
  }

  void clearTExtFeild() {
    if (searchingDrinkController.text.isEmpty) {
    } else {
      searchingDrinkController.clear();
    }
    notifyListeners();
  }

  bool get isUserNotSearch {
    bool isSeaching = searchingDrinkController.text.isEmpty;
    return isSeaching;
  }

  bool get isDrinkNotFound {
    bool isSearchingBarNotEmpty = searchingDrinkController.text.isNotEmpty;
    bool isItemExist = filteredDrinks.isEmpty;
    bool isFound = isSearchingBarNotEmpty && isItemExist;
    return isFound;
  }

  void chickList() {
    log("Drink List Length : ${drinkList.length}");
    log("Drink List : ${drinkList[0].foodType}");
  }
}

class SearchDrinkWithFilter extends ChangeNotifier {
  // Searching Properties

  List<FoodModel> state = [];

  final BuildContext context = navigationKey.currentContext as BuildContext;

  String get _query =>
      ControllersManager.drinkSearchController!.text.trim().toLowerCase();

  List<FoodModel> get _searchBase {
    final int drinkType = context.read<CurrentIndexProvider>().drinkIndex;

    final List<FoodModel> searchBase =
        drinkType == 0 ? coldDrinksDemoData : dirnksDemoData;

    return searchBase;
  }

  // Searching Algorithm

  void searchDrinkCategory() {
    final RattingProvider rate = Provider.of<RattingProvider>(
      context,
      listen: false,
    );

    final PriceFilterProvider price = Provider.of<PriceFilterProvider>(
      context,
      listen: false,
    );

    for (int i = 0; i < _searchBase.length; i++) {
      final FoodModel item = _searchBase[i];

      final bool nameMatch = item.foodName.toLowerCase().contains(_query);

      final bool priceMatch = (price.isAll) ||
          (price.isCheap && item.foodPrice >= 5.0 && item.foodPrice <= 20.0) ||
          (price.isMedium && item.foodPrice >= 21 && item.foodPrice <= 50) ||
          (price.isHigh && item.foodPrice >= 51.0 && item.foodPrice <= 120.0);

      final bool rateMatch = rate.isAny ||
          (rate.isGood && item.foodRate >= 2.0 && item.foodRate <= 3.3) ||
          (rate.isExcellent && item.foodRate >= 3.4 && item.foodRate <= 5.0);

      final bool targetMatch = nameMatch && priceMatch && rateMatch;

      if (targetMatch) {
        Log.log(
            "Item {${i + 1}} with Name => ${item.foodName} has Match with Query");
        state = [...state, item];
      }
    }

    notifyListeners();
  }

  // Seatrching Status

  bool get isSearching => _query.isNotEmpty;

  bool get searchingWithData {
    final bool data = state.isNotEmpty;

    final bool hasData = isSearching && data;

    return hasData;
  }

  bool get searchWithNoData {
    final bool empty = state.isEmpty;

    final bool noData = isSearching && empty;

    return noData;
  }
}
