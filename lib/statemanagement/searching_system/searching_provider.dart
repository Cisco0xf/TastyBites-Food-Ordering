import 'package:flutter/material.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/price_filter_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/ratting_provider.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories_items.dart';
import 'package:provider/provider.dart';

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

    SearchingFilterProvider filterPrice = Provider.of<SearchingFilterProvider>(
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
