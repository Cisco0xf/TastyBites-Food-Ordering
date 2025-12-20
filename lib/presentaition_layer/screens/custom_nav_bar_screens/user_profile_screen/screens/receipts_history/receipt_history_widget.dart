import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/receipt_management/receipt_history_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/screens/receipts_history/empty_history.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/screens/receipts_history/new_history_receipt.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/screens/receipts_history/receipt_info.dart';
import 'package:provider/provider.dart';

class ReceiptHistoryWidget extends StatelessWidget {
  const ReceiptHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: context.screenWidth * .1,
        titleSpacing: 0,
        title: Center(
          child: Text(
            "receipt_history_title".localeValue(context: context),
            style: TextStyle(
              color: Colors.black,
              fontFamily: context.isEnglish ? null : FontFamily.mainArabic,
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: context.read<ManageReceiptHistory>().hasData
          ? const ReceiptList()
          : const EmptyReceiptWidget(),
    );
  }
}

class ReceiptList extends StatelessWidget {
  const ReceiptList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ReceiptModel> history =
        context.watch<ManageReceiptHistory>().state;
    return Column(
      children: <Widget>[
        const ReceiptInfoWidget(),
        Expanded(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Container(
                padding: padding(10),
                margin: padding(10),
                decoration: BoxDecoration(
                  color: SwitchColor.receiptColor,
                  borderRadius: borderRaduis(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Localizations(
                      locale: const Locale("en"),
                      delegates: const <LocalizationsDelegate<dynamic>>[
                        DefaultMaterialLocalizations.delegate,
                        DefaultWidgetsLocalizations.delegate,
                      ],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text("Ordered in :"),
                              Container(
                                padding: padding(7),
                                margin: padding(5),
                                decoration: BoxDecoration(
                                  borderRadius: borderRaduis(10),
                                  color: SwitchColor.fillColor,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Text(history[index].dateTime),
                              ),
                            ],
                          ),
                          Text(
                            history[index].newReceipt,
                            overflow: TextOverflow.fade,
                            maxLines: 6,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return NewReceiptWidget(
                                    receipt: history[index],
                                    /* newReceipt: history[index].newReceipt,
                                    dateTime: history[index].dateTime, */
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            "receipt_button".localeValue(context: context),
                            style: TextStyle(
                              fontFamily: context.isEnglish
                                  ? FontFamily.mainFont
                                  : FontFamily.mainArabic,
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
