import 'package:flutter/material.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';

TextStyle typePriceTextStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.green,
);

TextStyle typeNameTextStyle = const TextStyle(
  fontFamily: FontFamily.mainFont,
  fontWeight: FontWeight.bold,
  fontSize: 13,
);

class AppTextStyles {
  static TextStyle mainWidgetTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        fontFamily: FontFamily.mainFont,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      );
    } else {
      return const TextStyle(
        fontFamily: FontFamily.mainArabic,
        fontSize: 24,
      );
    }
  }

  static TextStyle profileWidgetTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        fontFamily: FontFamily.mainFont,
        fontSize: 17,
      );
    } else {
      return const TextStyle(
        fontFamily: FontFamily.mainArabic,
        fontSize: 17,
      );
    }
  }

  static TextStyle categoriesTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        fontFamily: FontFamily.subFont,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 15,
      );
    } else {
      return const TextStyle(
        fontFamily: FontFamily.mainArabic,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 15,
      );
    }
  }

  static TextStyle orderNowButtonTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        color: Colors.white,
        fontFamily: FontFamily.subFont,
        fontWeight: FontWeight.bold,
      );
    } else {
      return const TextStyle(
        color: Colors.white,
        fontFamily: FontFamily.mainArabic,
        fontWeight: FontWeight.bold,
      );
    }
  }

  static TextStyle addToCartButtonTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        fontSize: 15,
      );
    } else {
      return const TextStyle(
        fontSize: 15,
        fontFamily: FontFamily.mainArabic,
      );
    }
  }

  static TextStyle chickoutButtonTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
        fontSize: 15,
      );
    } else {
      return const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: FontFamily.mainArabic,
        letterSpacing: 1.2,
        fontSize: 17,
      );
    }
  }

  static TextStyle chooseButtonTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        fontSize: 16,
        fontFamily: FontFamily.mainFont,
        fontWeight: FontWeight.bold,
      );
    } else {
      return const TextStyle(
        fontSize: 16,
        fontFamily: FontFamily.mainArabic,
        fontWeight: FontWeight.bold,
      );
    }
  }

  static TextStyle filterTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        fontSize: 18,
        color: Color(0xFF757575),
        fontFamily: FontFamily.mainFont,
      );
    } else {
      return const TextStyle(
        fontSize: 18,
        color: Color(0xFF757575),
        fontFamily: FontFamily.mainArabic,
      );
    }
  }

  static TextStyle filterItemTextStyle({required BuildContext context}) {
    if (context.isEnglish) {
      return const TextStyle(
        fontSize: 15,
        fontFamily: FontFamily.mainFont,
      );
    } else {
      return const TextStyle(
        fontSize: 17,
        fontFamily: FontFamily.mainArabic,
      );
    }
  }
}
