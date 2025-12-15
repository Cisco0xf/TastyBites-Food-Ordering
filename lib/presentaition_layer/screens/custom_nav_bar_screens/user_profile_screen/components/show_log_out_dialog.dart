import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

Future<void> showLogoutDialog() async {
  final BuildContext context = navigationKey.currentContext!;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: borderRaduis(10.0),
        ),
        child: const SignOutDialog(),
      );
    },
  );
}

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  Widget _buttonSize({required Widget child, required BuildContext context}) {
    return SizedBox(
      width: context.screenWidth * .35,
      height: context.screenHeight * .06,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          const Gap(hRatio: 0.01),
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
          const Gap(hRatio: 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buttonSize(
                context: context,
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
                    "cancel".localeValue(context: context),
                    style: context.isEnglish
                        ? null
                        : const TextStyle(
                            fontFamily: FontFamily.mainArabic,
                            fontSize: 16,
                          ),
                  ),
                ),
              ),
              _buttonSize(
                context: context,
                child: Consumer<FireAuthProvider>(
                  builder: (context, signout, _) {
                    return MaterialButton(
                      onPressed: () async => await signout.signOutFromApp(),
                      color: const Color(0xFFA34343),
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRaduis(15.0),
                      ),
                      child: signout.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                const Icon(Icons.logout, color: Colors.orange),
                                Text(
                                  "log_out".localeValue(context: context),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
