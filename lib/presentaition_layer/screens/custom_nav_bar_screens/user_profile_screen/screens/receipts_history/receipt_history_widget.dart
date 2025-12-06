import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_history_provider.dart';
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
      body: Consumer<ReceiptHistoryProvider>(
        builder: (context, receiptHistory, child) {
          return FutureBuilder(
            future: receiptHistory.waitToLoadding,
            builder: (context, snapshot) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (receiptHistory.receiptHistoryList.isEmpty) {
                    return receiptHistory.isLoadding
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const EmptyReceiptWidget();
                  } else {
                    return Column(
                      children: <Widget>[
                        const ReceiptInfoWidget(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: receiptHistory.receiptHistoryList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: SwitchColors.receiptColor,
                                  borderRadius: borderRaduis(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Localizations(
                                      locale: const Locale("en"),
                                      delegates: const <LocalizationsDelegate<
                                          dynamic>>[
                                        DefaultMaterialLocalizations.delegate,
                                        DefaultWidgetsLocalizations.delegate,
                                      ],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              const Text("Ordered in :"),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(7),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      borderRaduis(10),
                                                  color:
                                                      SwitchColors.dateBoxColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Text(receiptHistory
                                                    .receiptHistoryList[index]
                                                    .dateTime),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            receiptHistory
                                                .receiptHistoryList[index]
                                                .newReceipt,
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
                                                    newReceipt: receiptHistory
                                                        .receiptHistoryList[
                                                            index]
                                                        .newReceipt,
                                                    dateTime: receiptHistory
                                                        .receiptHistoryList[
                                                            index]
                                                        .dateTime,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "receipt_button"
                                                .localeValue(context: context),
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
                },
              );
            },
          );
        },
      ),
    );
  }
}
