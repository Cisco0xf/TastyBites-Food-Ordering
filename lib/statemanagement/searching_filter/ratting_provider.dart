import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';

class RattingProvider with ChangeNotifier {
  RattingFilterEnum selectedRate = RattingFilterEnum.any;
  void getUserRate({
    required RattingFilterEnum choosedRate,
  }) {
    selectedRate = choosedRate;
    log("User select : $choosedRate");
    notifyListeners();
  }

  bool get isAny {
    bool isAny = selectedRate == RattingFilterEnum.any;
    return isAny;
  }

  bool get isGood {
    bool isGood = selectedRate == RattingFilterEnum.medium;
    return isGood;
  }

  bool get isExcellent {
    bool isEx = selectedRate == RattingFilterEnum.medium;
    return isEx;
  }

  String rattingFilter({required BuildContext context}) {
    String rattingFilter = "";
    if (isAny) {
      rattingFilter = "any_rate".localeValue(context: context);
    } else if (isGood) {
      rattingFilter = "good_rate".localeValue(context: context);
    } else {
      rattingFilter = "excellent".localeValue(context: context);
    }

    return rattingFilter;
  }
}

enum RattingFilterEnum {
  any,
  medium,
  high,
}
