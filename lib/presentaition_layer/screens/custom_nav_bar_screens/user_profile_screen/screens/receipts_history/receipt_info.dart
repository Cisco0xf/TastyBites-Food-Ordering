import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/screens/receipts_history/clear_receipt_dialog.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_history_provider.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class ReceiptInfoWidget extends StatelessWidget {
  const ReceiptInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageReceiptHistory>(
      builder: (context, receipts, child) {
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
                          text: "${receipts.state.length}",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                          )),
                      TextSpan(
                        text: receipts.state.length == 1
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
                onPressed: () async => await clearReceiptDialog(context),
                shape: RoundedRectangleBorder(borderRadius: borderRaduis(10)),
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
