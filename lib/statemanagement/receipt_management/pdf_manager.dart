import 'dart:io';
import 'dart:typed_data';

import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/common/commons.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class ReceiptPdf {
  // Get the Directory of the file   | Before => 09:19:22 ==== After =>

  Future<String> _targetFilePath(String fileName) async {
    late final Directory dire;

    try {
      dire = await getApplicationDocumentsDirectory();
    } catch (error) {
      Log.error("App Directory Error => $error");
    }

    final String fullPath = "${dire.path}/${fileName}_TastyBites.pdf";

    return fullPath;
  }

  // Save File After Generating

  Future<String> _writeFile(
      {required Document pdf, required String fileName}) async {
    final String filePath = await _targetFilePath(fileName);

    final Uint8List pdfBytes = await pdf.save();

    final File file = File(filePath);

    try {
      await file.writeAsBytes(pdfBytes, flush: true);
    } catch (error) {
      Log.error("Write Pdf Error => $error");
    }

    return filePath;
  }

  // Generate the file

  Future<void> _generatePdfFile({required ReceiptModel receipt}) async {
    /*  final bool hasPermission = await _checkStoragePermission();

    if (!hasPermission) {
      showToastification(
        message: "You need Storage permission to download the pdf receipt",
      );
      return;
    } */

    final Document pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) {
          return <Widget>[
            Text(
              "TastyBites",
              style: TextStyle(
                fontSize: 30,
                color: PdfColor.fromHex("#FF9800"),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              receipt.newReceipt,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "-" * 45,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Open Source | By Mahmoud Alshehyby",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ];
        },
      ),
    );

    final String file = await _writeFile(pdf: pdf, fileName: receipt.id);

    try {
      await OpenFile.open(file);
    } catch (error) {
      Log.error("Open file error => $error");
    }
  }

  // Check Storage permission && Implement the Logic

  Future<void> generateREceipt(ReceiptModel receipt) async {
    PermissionStatus storage = await Permission.storage.status;

    if (!storage.isGranted) {
      await _generatePdfFile(receipt: receipt);

      return;
    }

    if (storage.isGranted) {
      await _generatePdfFile(receipt: receipt);

      return;
    }

    showToastification(
      message: "You need Storage permission to download the pdf receipt",
    );
  }
}
