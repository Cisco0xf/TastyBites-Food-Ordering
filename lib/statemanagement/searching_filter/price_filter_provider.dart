import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';

class PriceFilterProvider extends ChangeNotifier {
  int currentFilter = 0;

  void selectFilter(int filter) {
    currentFilter = filter;
    notifyListeners();
  }

  bool get isAll => currentFilter == 0;
  bool get isCheap => currentFilter == 1;
  bool get isMedium => currentFilter == 2;
  bool get isHigh => currentFilter == 3;

  String priceRange({required BuildContext context}) {
    final String any = "any_price".localeValue(context: context);

    final Map<int, String> label = {
      0: any,
      1: "\$ 5 - \$ 20",
      2: "\$ 21 - \$ 50",
      3: "\$ 51 - \$ 120",
    };
    return label[currentFilter]!;
  }

  void resetFilter() {
    currentFilter = 0;
    notifyListeners();
  }
}

/* 
class SearchingFilterProvider with ChangeNotifier {
  bool isAll = true;
  bool isCheap = false;
  bool isMedium = false;
  bool isHigh = false;

  void get allPricesFilter {
    isAll = true;
    isCheap = false;
    isMedium = false;
    isHigh = false;
    notifyListeners();
  }

  void get cheapPricesFilter {
    isAll = false;
    isCheap = true;
    isMedium = false;
    isHigh = false;
    notifyListeners();
  }

  void get mediumPricesFilter {
    isAll = false;
    isCheap = false;
    isMedium = true;
    isHigh = false;
    notifyListeners();
  }

  void get highPricesFilter {
    isAll = false;
    isCheap = false;
    isMedium = false;
    isHigh = true;
    notifyListeners();
  }

  String priceRange({required BuildContext context}) {
    String priceRange = "";
    if (isAll) {
      priceRange = "any_price".localeValue(context: context);
    } else if (isCheap) {
      priceRange = "\$ 5 - \$ 20";
    } else if (isMedium) {
      priceRange = "\$ 21 - \$ 50";
    } else {
      priceRange = "\$ 51 - \$ 120";
    }
    return priceRange;
  }
}
 */