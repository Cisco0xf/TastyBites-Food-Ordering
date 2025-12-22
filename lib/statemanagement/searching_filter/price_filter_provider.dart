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
