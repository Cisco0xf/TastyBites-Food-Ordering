import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';

Future<void> get showExitDialog async {
  final BuildContext context = navigationKey.currentContext!;
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: borderRaduis(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "exit_app".localeValue(context: context),
                style: context.isEnglish
                    ? const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )
                    : const TextStyle(
                        fontSize: 18,
                        fontFamily: FontFamily.mainArabic,
                      ),
              ),
              SizedBox(
                height: context.screenHeight * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: context.screenWidth * .35,
                    height: context.screenHeight * .06,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRaduis(15.0),
                        ),
                      ),
                      child: Text(
                        "cancel".localeValue(
                          context: context,
                        ),
                        style: context.isEnglish
                            ? const TextStyle(
                                fontSize: 16,
                              )
                            : const TextStyle(
                                fontSize: 16,
                                fontFamily: FontFamily.mainArabic,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth * .35,
                    height: context.screenHeight * .06,
                    child: MaterialButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRaduis(15.0),
                      ),
                      color: const Color(0xFFA34343),
                      child: Text(
                        "exit".localeValue(context: context),
                        style: context.isEnglish
                            ? const TextStyle(
                                fontSize: 16,
                              )
                            : const TextStyle(
                                fontSize: 16,
                                fontFamily: FontFamily.mainArabic,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
