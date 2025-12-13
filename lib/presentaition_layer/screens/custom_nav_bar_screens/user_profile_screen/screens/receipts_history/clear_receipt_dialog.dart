import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/receipt_management/receipt_history_provider.dart';
import 'package:provider/provider.dart';

Future<void> clearReceiptDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Consumer<ManageReceiptHistory>(
        builder: (context, clearReceipt, child) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            title: Text(
              "clear_receipt".localeValue(context: context),
              style: TextStyle(
                color: Colors.red,
                fontFamily: context.isEnglish ? null : FontFamily.mainArabic,
                fontSize: 20,
              ),
            ),
            content: Text(
              "confirm_clear_receipt".localeValue(context: context),
              style: TextStyle(
                fontFamily: context.isEnglish
                    ? FontFamily.mainFont
                    : FontFamily.mainArabic,
                fontSize: 17,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "cancle".localeValue(context: context),
                  style: TextStyle(
                    fontFamily:
                        context.isEnglish ? null : FontFamily.mainArabic,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  await clearReceipt.clearHistory();
                  Navigator.pop(navigationKey.currentContext!);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: borderRaduis(10),
                ),
                color: const Color(0xFFFFC374),
                child: Text(
                  "clear".localeValue(context: context),
                  style: TextStyle(
                    fontFamily: context.isEnglish
                        ? FontFamily.mainFont
                        : FontFamily.mainArabic,
                  ),
                ),
              )
            ],
          );
        },
      );
    },
  );
}
