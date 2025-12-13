import 'dart:io';
import 'dart:typed_data';

import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/data_layer/data_base/receipt_db/receipt_model.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class ReceiptPdf {
  // Check Storage permission

  Future<bool> _checkStoragePermission() async {
    final PermissionStatus storage = await Permission.storage.status;

    final bool isGranted = storage == PermissionStatus.granted;

    if (!isGranted) {
      await Permission.storage.request();

      return false;
    }
    return true;
  }

  // Get the Directory of the file

  Future<String> _targetFilePath() async {
    late final Directory dire;

    try {
      dire = await getApplicationDocumentsDirectory();
    } catch (error) {
      Log.error("App Directory Error => $error");
    }

    final String path = dire.path;

    return path;
  }

  // Save to the Locale Storage

  Future<File> savePdfAfterGenerating({
    required String fileName,
    required Document pdf,
  }) async {
    final Uint8List pdfFile = await pdf.save();

    final String path = await _targetFilePath();

    final String fullPath = "$path/${fileName}_TastyBites.pdf";

    final File file = File(fullPath);

    try {
      await file.writeAsBytes(pdfFile, flush: true);
    } catch (error) {
      Log.error("Error Writes Pdf => $error");
    }

    return file;
  }

  // Generate the file

  Future<void> generatePdfFile({required ReceiptModel receipt}) async {
    final bool hasPermission = await _checkStoragePermission();

    if (!hasPermission) {
      ReusableMethods.showtoastification(
        message: "You need Storage permission to download the pdf receipt",
      );
      return;
    }

    final Document pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) {
          return [
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

    final File file = await savePdfAfterGenerating(
      fileName: receipt.id,
      pdf: pdf,
    );

    try {
      await OpenFile.open(file.path);
    } catch (error) {
      Log.error("Open file error => $error");
    }
  }
}
