import 'package:flutter/material.dart';
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
