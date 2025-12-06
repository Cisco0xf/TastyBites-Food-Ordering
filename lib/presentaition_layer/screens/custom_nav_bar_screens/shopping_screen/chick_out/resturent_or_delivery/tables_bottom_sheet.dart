import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/user_table/get_user_table.dart';
import 'package:provider/provider.dart';

import '../../../../../../statemanagement/localization/localization_provider.dart';

void showTablesSheet() {
  final BuildContext context = navigationKey.currentContext as BuildContext;
  showModalBottomSheet(
    isDismissible: false,
    constraints: BoxConstraints(
      maxHeight: context.screenHeight * .6,
    ),
    context: context,
    builder: (context) {
      return const TablesSheet();
    },
  );
}

class TablesSheet extends StatefulWidget {
  const TablesSheet({super.key});

  @override
  State<TablesSheet> createState() => _TablesSheetState();
}

class _TablesSheetState extends State<TablesSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TableProvider>(
      builder: (context, userTable, _) {
        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              width: context.screenWidth * .6,
              height: context.screenHeight * .05,
              decoration: BoxDecoration(
                borderRadius: borderRaduis(15),
                color: const Color(0xFFF3B664),
              ),
              alignment: Alignment.center,
              child: Text("choose_table".localeValue(context: context),
                  style: AppTextStyles.chooseButtonTextStyle(context: context)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tables.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    value: tables[index],
                    groupValue: userTable.selectedTable,
                    onChanged: (table) {
                      setState(
                        () => userTable.selectTable(table as String),
                      );
                    },
                    title: Text("Table : ${tables[index]}"),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: context.screenWidth * .8,
              height: context.screenHeight * .06,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Table selected");
                },
                color: Colors.orange,
                child: Consumer<LocalizationProvider>(
                  builder: (context, localization, child) {
                    return Text(
                      "choose__table".localeValue(context: context),
                      style: TextStyle(
                        fontFamily:
                            context.isEnglish ? null : FontFamily.mainArabic,
                        fontSize: context.isEnglish ? null : 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
