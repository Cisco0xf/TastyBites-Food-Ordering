import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/payment_screen/payment_card.dart';

class AddressProvider with ChangeNotifier {
  /* final TextEditingController _addressController = TextEditingController();

  TextEditingController get addressController => _addressController; */

  TextEditingController? addressController;

  void initAddressController() {
    addressController = TextEditingController();
  }

  void disposeController() {
    addressController?.dispose();
  }

  // GET user address

  String userAddress = "User Address";

  void getUserAddress() {
    userAddress = addressController!.text;
    notifyListeners();
  }

  bool get isAddressEmpty {
    bool isEmpty = addressController!.text.trim().isEmpty;
    return isEmpty;
  }
  // Show error if exist

  String error = "";

  void showError({required BuildContext context}) {
    if (isAddressEmpty) {
      error = "location_error".localeValue(
        context: context,
      );
      notifyListeners();
    } else {
      error = "";
      notifyListeners();
    }
  }

  // Clear custom error

  void get clearError {
    error = "";
    notifyListeners();
  }

  void clearAddress() {
    userAddress = "User Address";
  }
  // Chick the statement

  void chickStatement({
    required BuildContext context,
    required bool isSingleItem,
  }) {
    if (!isAddressEmpty) {
      getUserAddress();
      showError(context: context);
      pushTo(PaymentCardScreen(isSingleItem: isSingleItem));

      return;
    }

    showError(context: context);
  }
}
