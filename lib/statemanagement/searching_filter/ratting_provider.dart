import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';

class RattingProvider with ChangeNotifier {
  RateFilter selectedRate = RateFilter.any;

  void getUserRate({
    required RateFilter choosedRate,
  }) {
    selectedRate = choosedRate;
    log("User select : $choosedRate");
    notifyListeners();
  }

  bool get isAny => selectedRate == RateFilter.any;

  bool get isGood => selectedRate == RateFilter.medium;

  bool get isExcellent => selectedRate == RateFilter.medium;

  String rattingFilter() {
    final BuildContext context = navigationKey.currentContext as BuildContext;

    if (isAny) {
      return "any_rate".localeValue(context: context);
    }

    if (isGood) {
      return "good_rate".localeValue(context: context);
    }

    return "excellent".localeValue(context: context);
  }
}
