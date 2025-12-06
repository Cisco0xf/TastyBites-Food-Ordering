import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/statemanagement/authantications/authentication_provider.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/presentaition_layer/auth/push_to_auth/push_auth_screen.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

Future<void> get showLogoutDialog async {
  final BuildContext context = navigationKey.currentContext!;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRaduis(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "log_out".localeValue(context: context),
                style: context.isEnglish
                    ? const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                    : const TextStyle(
                        fontFamily: FontFamily.mainArabic,
                        fontSize: 16,
                      ),
              ),
              SizedBox(
                height: context.screenHeight * .01,
              ),
              Text(
                "ask_log_out".localeValue(context: context),
                style: context.isEnglish
                    ? const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      )
                    : const TextStyle(
                        fontFamily: FontFamily.mainArabic,
                        fontSize: 16,
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
                            ? null
                            : const TextStyle(
                                fontFamily: FontFamily.mainArabic,
                                fontSize: 16,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth * .38,
                    height: context.screenHeight * .06,
                    child: Consumer<CurrentIndexProvider>(
                      builder: (context, currentContent, _) {
                        return Consumer<AuthenticationProvider>(
                          builder: (context, signOut, child) {
                            return MaterialButton(
                              onPressed: () {
                                signOut
                                    .signOut(
                                  context: context
                                )
                                    .whenComplete(
                                  () {
                                    currentContent.switchContent(1);
                                  },
                                );
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const PushAuthScreen();
                                    },
                                  ),
                                  (route) {
                                    return false;
                                  },
                                );
                              },
                              color: const Color(0xFFA34343),
                              shape: RoundedRectangleBorder(
                                borderRadius: borderRaduis(15.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  const Icon(
                                    Icons.logout,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    "log_out".localeValue(context: context),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
