import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_history_provider.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class ReceiptInfoWidget extends StatelessWidget {
  const ReceiptInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiptHistoryProvider>(
      builder: (context, receiptHistory, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              const Expanded(
                flex: 2,
                child: Divider(
                  color: Color(0xFF124076),
                  endIndent: 10,
                  thickness: 1.2,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                          text: "${receiptHistory.receiptHistoryList.length}",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                          )),
                      TextSpan(
                        text: receiptHistory.receiptHistoryList.length == 1
                            ? "receipt".localeValue(context: context)
                            : "receipts".localeValue(context: context),
                        style: TextStyle(
                          fontFamily: context.isEnglish
                              ? FontFamily.mainFont
                              : FontFamily.mainArabic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 5,
                child: Divider(
                  color: Color(0xFF124076),
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.2,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Consumer<ReceiptHistoryProvider>(
                        builder: (context, clearReceipt, child) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.all(10),
                            title: Text(
                              "clear_receipt".localeValue(context: context),
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: context.isEnglish
                                    ? null
                                    : FontFamily.mainArabic,
                                fontSize: 20,
                              ),
                            ),
                            content: Text(
                              "confirm_clear_receipt"
                                  .localeValue(context: context),
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
                                    fontFamily: context.isEnglish
                                        ? null
                                        : FontFamily.mainArabic,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  clearReceipt.clearReceiptHistory;
                                  Navigator.pop(context);
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
              ),
            ],
          ),
        );
      },
    );
  }
}
