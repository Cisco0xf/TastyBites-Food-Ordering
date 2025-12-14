import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:toastification/toastification.dart';

import 'package:foodapp/statemanagement/localization/language_of_app.dart';

void showToastification({
  required String message,
  Color progressBarColor = const Color(0xFFEE9322),
  ToastificationType type = ToastificationType.info,
  bool showProgressBar = false,
}) {
  final BuildContext context = navigationKey.currentContext!;
  toastification.show(
    context: context,
    applyBlurEffect: true,
    dragToClose: true,
    showProgressBar: showProgressBar,
    autoCloseDuration: const Duration(seconds: 2),
    direction: context.isEnglish ? TextDirection.ltr : TextDirection.rtl,
    alignment: Alignment.bottomCenter,
    animationDuration: const Duration(milliseconds: 250),
    progressBarTheme: ProgressIndicatorThemeData(
      color: progressBarColor,
    ),
    type: type,
    description: Text(
      message,
      textAlign: context.isEnglish ? TextAlign.left : TextAlign.right,
      style: TextStyle(
        fontFamily:
            context.isEnglish ? FontFamily.mainFont : FontFamily.mainArabic,
        fontSize: 14,
      ),
    ),
  );
}

class ReusableMethods {
  static Future<dynamic> showAwesomDialog({
    required BuildContext context,
    required String description,
    required String title,
    DialogType dialogType = DialogType.error,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.rightSlide,
      dialogType: dialogType,
      title: title,
      titleTextStyle: const TextStyle(
        fontFamily: FontFamily.mainFont,
        color: Color(0xFFFE7A36),
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      transitionAnimationDuration: const Duration(
        milliseconds: 250,
      ),
      autoHide: const Duration(
        seconds: 3,
      ),
      desc: description,
      descTextStyle: const TextStyle(
        fontSize: 17,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
        fontFamily: FontFamily.mainFont,
      ),
      dismissOnTouchOutside: true,
    ).show();
  }

  static void showNotification({
    required String title,
    required String description,
    ToastificationType type = ToastificationType.info,
  }) {
    toastification.show(
      context: navigationKey.currentContext!,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
          fontFamily: FontFamily.mainFont,
        ),
      ),
      description: Text(
        description,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: FontFamily.mainFont,
        ),
      ),
      type: type,
      direction: TextDirection.ltr,
      alignment: Alignment.topCenter,
      borderRadius: borderRaduis(15),
      showProgressBar: true,
      animationDuration: const Duration(milliseconds: 2),
      autoCloseDuration: const Duration(seconds: 2),
      applyBlurEffect: true,
      dragToClose: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
