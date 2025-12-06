/* import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';

class QuantityProvider with ChangeNotifier {
  void addOnePice({required int quantity}) {
    quantity++;
    log(quantity.toString());
    notifyListeners();
  }

  void removeOnePice({
    required int quantity,
    required BuildContext context,
  }) {
    if (quantity <= 1) {
      ReusableMethods.showtoastification(
        context: context,
        message: "Minemun number is 1",
      );
    } else {
      quantity--;
    }
    notifyListeners();
  }
}
 */