import 'package:flutter/material.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/drinks_cold_demo_data.dart';
import 'package:foodapp/data_layer/data_models/drinks_hot_demo_data.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/price_filter_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/ratting_provider.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories_items.dart';
import 'package:foodapp/statemanagement/searching_system/controllers_manager.dart';
import 'package:provider/provider.dart';

class SearchingProvider extends ChangeNotifier {
  List<FoodModel> filterdFood = [];

  final BuildContext context = navigationKey.currentContext as BuildContext;

  int get currentCategory => context.read<CurrentIndexProvider>().currentIndex;

  bool get filterDrinks => currentCategory == 1;

  TextEditingController? get searchController => filterDrinks
      ? ControllersManager.drinkSearchController
      : ControllersManager.searchingController;

  String? get _query => searchController?.text.trim().toLowerCase();

  bool get _isNotInit => _query == null;

  bool _matchPrice(FoodModel item) {
    final PriceFilterProvider price = Provider.of<PriceFilterProvider>(
      context,
      listen: false,
    );

    final bool priceMatch = (price.isAll) ||
        (price.isCheap && item.foodPrice >= 5.0 && item.foodPrice <= 20.0) ||
        (price.isMedium && item.foodPrice >= 21 && item.foodPrice <= 50) ||
        (price.isHigh && item.foodPrice >= 51.0 && item.foodPrice <= 120.0);

    return priceMatch;
  }

  bool _matchRate(FoodModel item) {
    final RattingProvider rate = Provider.of<RattingProvider>(
      context,
      listen: false,
    );

    final bool rateMatch = rate.isAny ||
        (rate.isGood && item.foodRate >= 2.0 && item.foodRate <= 3.3) ||
        (rate.isExcellent && item.foodRate >= 3.4 && item.foodRate <= 5.0);

    return rateMatch;
  }

  void _searchInCategory({bool updateUi = true}) {
    final List<FoodModel> targetFilter =
        categoriesItems[currentCategory].filteredList;

    filterdFood = List.from(targetFilter);

    filterdFood = targetFilter.where(
      (FoodModel food) {
        if (_isNotInit) {
          return true;
        }

        final bool matchName = food.foodName.toLowerCase().contains(_query!);

        final bool goodToGo =
            matchName && _matchRate(food) && _matchPrice(food);

        Log.log(
          "Item Name => ${food.foodName} | Price => ${food.foodPrice} | Match Price => ${_matchPrice(food)}",
          color: _matchPrice(food) ? LColor.green : LColor.red,
        );

        return goodToGo;
      },
    ).toList();

    if (!updateUi) {
      return;
    }

    notifyListeners();
  }

  // =============== Drinks Searching System =================

  List<FoodModel> state = [];

  List<FoodModel> get _searchBase {
    final int drinkType = context.read<CurrentIndexProvider>().drinkIndex;

    final List<FoodModel> searchBase =
        drinkType == 0 ? coldDrinksDemoData : dirnksDemoData;

    return searchBase;
  }

  // Searching Algorithm

  void _searchDrinkCategory() {
    for (int i = 0; i < _searchBase.length; i++) {
      final FoodModel item = _searchBase[i];

      if (_isNotInit) {
        return;
      }

      final bool nameMatch = item.foodName.toLowerCase().contains(_query!);

      final bool targetMatch =
          nameMatch && _matchPrice(item) && _matchRate(item);

      if (targetMatch) {
        Log.log(
            "Item {${i + 1}} with Name => ${item.foodName} | Price => ${item.foodPrice}");

        state = [...state, item];
      }
    }

    notifyListeners();
  }

  // Seatrching Status

  bool get isSearching {
    if (_isNotInit) {
      return false;
    }

    return _query!.isNotEmpty;
  }

  bool get searchingWithData {
    final bool data = filterDrinks ? state.isNotEmpty : filterdFood.isNotEmpty;

    final bool hasData = data && isSearching;

    return hasData;
  }

  bool get searchingWithoutData {
    final bool data = filterDrinks ? state.isEmpty : filterdFood.isEmpty;

    final bool hasRateFilter = !(context.read<RattingProvider>().isAny);
    final bool hasPriceFilter = !(context.read<PriceFilterProvider>().isAll);

    final bool hasNoData =
        data && (isSearching || hasPriceFilter || hasRateFilter);

    /* final bool hasNoData = (data && isSearching) ||
        (data && hasRateFilter) ||
        (data && hasPriceFilter); */

    return hasNoData;
  }

  void filtesearchWithFilterCategoriesItems({bool updateUI = true}) {
    if (!filterDrinks) {
      _searchInCategory(updateUi: updateUI);

      return;
    }

    _searchDrinkCategory();
  }

  List<FoodModel> get filtred => filterDrinks ? state : filterdFood;

  void clearFilterAndSearch() {
    context.read<RattingProvider>().resetRate();
    context.read<PriceFilterProvider>().resetFilter();
    searchController!.clear();

    filtesearchWithFilterCategoriesItems();

    notifyListeners();
  }
}

class SearchingSystemProvider with ChangeNotifier {
  // Filtered List
  List<FoodModel> filteredList = [];

  TextEditingController searchingProductsController = TextEditingController();

  // Function filtering the list

  void searchInCategory({
    required BuildContext context,
  }) {
    CurrentIndexProvider currentCategory = Provider.of<CurrentIndexProvider>(
      context,
      listen: false,
    );

    PriceFilterProvider filterPrice = Provider.of<PriceFilterProvider>(
      context,
      listen: false,
    );

    RattingProvider rattingFilter = Provider.of<RattingProvider>(
      context,
      listen: false,
    );

    filteredList =
        List.from(categoriesItems[currentCategory.currentIndex].filteredList);

    if (rattingFilter.isAny) {
      if (filterPrice.isAll) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return item.foodName.toLowerCase().contains(
                  searchingProductsController.text.toLowerCase(),
                );
          },
        ).toList();
      } else if (filterPrice.isCheap) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodPrice >= 5) &&
                (item.foodPrice <= 20) &&
                (item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    ));
          },
        ).toList();
      } else if (filterPrice.isMedium) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodPrice >= 21) &&
                (item.foodPrice <= 50) &&
                item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodPrice >= 51) &&
                (item.foodPrice <= 120) &&
                item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    );
          },
        ).toList();
      }
    } else if (rattingFilter.isGood) {
      if (filterPrice.isAll) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodRate >= 2.0) &&
                (item.foodRate <= 3.2) &&
                item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else if (filterPrice.isCheap) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodRate >= 2.0) &&
                (item.foodRate <= 3.2) &&
                (item.foodPrice >= 5) &&
                (item.foodPrice <= 20) &&
                (item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    ));
          },
        ).toList();
      } else if (filterPrice.isMedium) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodRate >= 3.3) &&
                (item.foodRate <= 5.0) &&
                (item.foodPrice >= 21) &&
                (item.foodPrice <= 50) &&
                item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodRate >= 3.3) &&
                (item.foodRate <= 5.0) &&
                (item.foodPrice >= 51) &&
                (item.foodPrice <= 120) &&
                item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    );
          },
        ).toList();
      }
    } else {
      if (filterPrice.isAll) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodRate >= 3.3) &&
                (item.foodRate <= 5.0) &&
                item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else if (filterPrice.isCheap) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodRate >= 3.3) &&
                (item.foodRate <= 5.0) &&
                (item.foodPrice >= 5) &&
                (item.foodPrice <= 20) &&
                (item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    ));
          },
        ).toList();
      } else if (filterPrice.isMedium) {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodRate >= 3.3) &&
                (item.foodRate <= 5.0) &&
                (item.foodPrice >= 21) &&
                (item.foodPrice <= 50) &&
                item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    );
          },
        ).toList();
      } else {
        filteredList =
            categoriesItems[currentCategory.currentIndex].filteredList.where(
          (item) {
            return (item.foodRate >= 3.3) &&
                (item.foodRate <= 5.0) &&
                (item.foodPrice >= 51) &&
                (item.foodPrice <= 120) &&
                item.foodName.toLowerCase().contains(
                      searchingProductsController.text.toLowerCase(),
                    );
          },
        ).toList();
      }
    }

    notifyListeners();
  }

  // Chick if the filtered list is empty

  bool get isFilteredListEmpty {
    bool isListEmpty = filteredList.isEmpty;
    return isListEmpty;
  }

  // Chick if the Searcing bar is Empty

  bool get isSearchingBarEmpty {
    bool isEmpty = searchingProductsController.text.isEmpty;
    return isEmpty;
  }

  // Chick if the item is exist in the List

  bool get isItemNotExist {
    bool isSearchBarNotEmpty = searchingProductsController.text.isNotEmpty;
    bool isFilteredListEmpty = filteredList.isEmpty;

    bool isItemExist = isSearchBarNotEmpty && isFilteredListEmpty;

    return isItemExist;
  }
}
