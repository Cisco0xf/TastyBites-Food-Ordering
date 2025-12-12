import 'package:flutter/material.dart';

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

/* final List<String> tables = <String>[
  for (int i = 1; i <= 150; i++) i.toString(),
]; */
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
