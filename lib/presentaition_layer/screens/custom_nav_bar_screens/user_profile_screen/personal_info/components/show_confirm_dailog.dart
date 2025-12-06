import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

Future<void> showwConfirmUpdateDialog({
  required BuildContext gcontext,
}) async {
  final BuildContext navContext = navigationKey.currentContext!;
  await showDialog(
    context: navContext,
    builder: (context) {
      return Consumer<PersonalInfoProvider>(
        builder: (context, updateInfo, _) {
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
                child: Text(
                  "cancel".localeValue(context: context),
                ),
              ),
              SizedBox(
                width: context.screenWidth * .3,
                height: context.screenHeight * .06,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    updateInfo.updateUserName(
                      context: context,
                    );
                    updateInfo.updateBIO();
                    ReusableMethods.showAwesomDialog(
                      context: gcontext,
                      description:
                          "ubdated_successfully".localeValue(context: context),
                      title: "account_updated".localeValue(context: context),
                      dialogType: DialogType.success,
                    );
                  },
                  color: const Color(0xFFFFBB64),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRaduis(15),
                  ),
                  child: Text(
                    "save".localeValue(context: context),
                    style: context.isEnglish
                        ? const TextStyle(
                            fontSize: 17,
                          )
                        : const TextStyle(
                            fontFamily: FontFamily.mainArabic,
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
