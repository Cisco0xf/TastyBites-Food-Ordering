import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';

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
