import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/statemanagement/receipt_management/pdf_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewReceiptWidget extends StatelessWidget {
  const NewReceiptWidget({
    super.key,
    /* required this.newReceipt,
    required this.dateTime, */
    required this.receipt,
  });
  /* final String newReceipt;
  final String dateTime; */

  final ReceiptModel receipt;

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
              padding: padding(10),
              margin: padding(10),
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
                        padding: padding(7),
                        margin: padding(5),
                        decoration: BoxDecoration(
                          borderRadius: borderRaduis(10),
                          color: SwitchColors.dateBoxColor,
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(receipt.dateTime),
                      ),
                    ],
                  ),
                  Text(
                    receipt.newReceipt,
                    style: const TextStyle(
                      fontFamily: FontFamily.mainFont,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(height: 15.0),
            PdfDownloadButton(receipt: receipt),
          ],
        ),
      ),
    );
  }
}

class PdfDownloadButton extends StatelessWidget {
  const PdfDownloadButton({super.key, required this.receipt});

  final ReceiptModel receipt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRaduis(10.0),
        border: Border.all(color: Colors.orange, width: 1.5),
      ),
      child: Clicker(
        onClick: () async {
          await showLoadingPdfDialog();
          final ReceiptPdf pdf = ReceiptPdf();

          await pdf.generatePdfFile(receipt: receipt).whenComplete(() {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          });
        },
        innerPadding: 10.0,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.picture_as_pdf),
            Gap(width: 10.0),
            Text("Pdf Receipt"),
          ],
        ),
      ),
    );
  }
}

Future<void> showLoadingPdfDialog() async {
  final BuildContext context = navigationKey.currentContext as BuildContext;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: context.screenHeight * .1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRaduis(20),
                  color: Colors.black26,
                ),
                child: LoadingAnimationWidget.dotsTriangle(
                  color: Colors.orange,
                  size: 35.0,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
