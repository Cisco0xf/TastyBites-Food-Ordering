import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/payment_screen/payment_card.dart';
import 'package:toastification/toastification.dart';

class TableProvider extends ChangeNotifier {
  String selectedTable = "table";

  void selectTable(String table) {
    selectedTable = table;
    notifyListeners();
  }

  bool get hasTable => selectedTable != "table";

  void clearTable() {
    selectedTable = "table";
  }

}

final List<String> tables = <String>[
  for (int i = 1; i <= 150; i++) i.toString(),
];
/* 
class GetUserTableProvider with ChangeNotifier {
  // Get user Table
  String selectedTable = "table";

  void getSelectedTable({required String table}) {
    selectedTable = table;
    notifyListeners();
  }

  // Chick the statement

  void _clearTable() {
    selectedTable = "table";
    notifyListeners();
  }

  void chickCondition({
    required BuildContext context,
    required bool isSingleItem,
  }) {
    final bool noTable = selectedTable == "table";

    if (noTable) {
      ReusableMethods.showtoastification(
        message: "enter_your_table_toast".localeValue(context: context),
        type: ToastificationType.error,
      );

      return;
    }
    pushTo(PaymentCardScreen(isSingleItem: isSingleItem));
    _clearTable();
  }

  // Is Table Selected

  bool get isTableSelected {
    bool isTable = selectedTable == "table";

    return isTable;
  }

  // List of Tabals

  
} */
