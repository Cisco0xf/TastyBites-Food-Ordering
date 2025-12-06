import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/searching_filter/price_filter_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/ratting_provider.dart';
import 'package:provider/provider.dart';

class SearchingDrinksProvider with ChangeNotifier {
  late List<FoodModel> drinkList;

  final TextEditingController _searchingDrinkController =
      TextEditingController();

  TextEditingController get searchingDrinkController =>
      _searchingDrinkController;

  List<FoodModel> filteredDrinks = [];

  void filterDrinke({required BuildContext context}) {
    SearchingFilterProvider priceFilter = Provider.of<SearchingFilterProvider>(
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
