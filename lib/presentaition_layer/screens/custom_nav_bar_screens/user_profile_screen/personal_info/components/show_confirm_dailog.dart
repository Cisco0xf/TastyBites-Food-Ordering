import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/statemanagement/authantications/auth_operations.dart';
import 'package:foodapp/statemanagement/cloud_firestore/manage_metadata.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

Future<void> showConfirmUpdateDialog() async {
  final BuildContext context = navigationKey.currentContext!;
  await showDialog(
    context: context,
    builder: (context) {
      final bool isLoading = context.watch<AuthOperations>().isOperating ||
          context.watch<ManageUserMetadata>().isLoading;
      return AlertDialog(
        title: Text(
          "save_changes".localeValue(context: context),
          style: context.isEnglish
              ? const TextStyle(
                  fontFamily: FontFamily.mainFont,
                )
              : const TextStyle(
                  fontFamily: FontFamily.mainArabic,
                ),
        ),
        content: Text(
          "save_info".localeValue(context: context),
          style: context.isEnglish
              ? const TextStyle(
                  fontSize: 14,
                  fontFamily: FontFamily.mainFont,
                )
              : const TextStyle(
                  fontSize: 14,
                  fontFamily: FontFamily.mainArabic,
                ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("cancel".localeValue(context: context)),
          ),
          SizedBox(
            width: context.screenWidth * .3,
            height: context.screenHeight * .06,
            child: MaterialButton(
              onPressed: () async {
                await context.read<AuthOperations>().updateCurrentUsername();

                await navigationKey.currentContext!
                    .read<ManageUserMetadata>()
                    .updateUserBIO();

                popScreen();
              },
              color: const Color(0xFFFFBB64),
              shape: RoundedRectangleBorder(
                borderRadius: borderRaduis(15),
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      "save".localeValue(context: context),
                      style: context.isEnglish
                          ? const TextStyle(fontSize: 17)
                          : const TextStyle(fontFamily: FontFamily.mainArabic),
                    ),
            ),
          ),
        ],
      );
    },
  );
}
