import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/fonts.dart';

class NewReceiptWidget extends StatelessWidget {
  const NewReceiptWidget({
    super.key,
    required this.newReceipt,
    required this.dateTime,
  });
  final String newReceipt;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Center(
          child: Text("Your Receipt"),
        ),
      ),
      body: Localizations(
        locale: const Locale("en"),
        delegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate
        ],
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: borderRaduis(15),
                color: SwitchColors.receiptColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Ordered in :",
                        style: TextStyle(
                          fontFamily: FontFamily.mainFont,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: borderRaduis(10),
                          color: SwitchColors.dateBoxColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Text(dateTime),
                      ),
                    ],
                  ),
                  Text(
                    newReceipt,
                    style: const TextStyle(
                      fontFamily: FontFamily.mainFont,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
