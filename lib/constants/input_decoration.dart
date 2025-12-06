import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/constants/app_colors.dart';

InputDecoration dropDownInputDecoration() {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRaduis(20),
      borderSide: const BorderSide(
        color: Colors.orange,
      ),
    ),
    fillColor: const Color(0xFFF8F0E5),
    filled: true,
    prefixIcon: const Icon(
      Icons.timelapse,
      color: Colors.orange,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: borderRaduis(20),
    ),
  );
}

InputDecoration textFeildDecpration({
  required BuildContext context,
  isCollapsed = false,
}) {
  return InputDecoration(
    fillColor: SwitchColors.chickoutFillColor,
    isCollapsed: isCollapsed,
    filled: true,
    hintText: "address".localeValue(context: context),
    hintStyle: TextStyle(
      fontFamily: context.isEnglish ? null : FontFamily.mainArabic,
      fontWeight: FontWeight.bold,
    ),
    prefixIcon: const Icon(
      Icons.location_on_outlined,
      color: Colors.orange,
    ),
    suffixIcon: const Icon(
      Icons.keyboard_arrow_down_sharp,
      color: Colors.orange,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.orange,
        width: 1,
      ),
      borderRadius: borderRaduis(20),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRaduis(20),
      borderSide: BorderSide.none,
    ),
  );
}

InputDecoration creditCardinputDecoration({
  required String lableText,
  required String hintText,
}) {
  return InputDecoration(
    hintTextDirection: TextDirection.ltr,
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRaduis(10),
    ),
    filled: true,
    fillColor: SwitchColors.cardFormFieldFillColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRaduis(10),
      borderSide: const BorderSide(
        color: Colors.orange,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: borderRaduis(10),
      borderSide: const BorderSide(
        color: Colors.orange,
        width: 1,
      ),
    ),
    labelText: lableText,
    hintText: hintText,
  );
}
