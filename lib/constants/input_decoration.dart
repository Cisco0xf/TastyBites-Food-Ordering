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
      borderSide: BorderSide(
        color: SwitchColor.primaryO,
      ),
    ),
    fillColor: const Color(0xFFF8F0E5),
    filled: true,
    prefixIcon: Icon(
      Icons.timelapse,
      color: SwitchColor.primaryO,
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
    fillColor: SwitchColor.fillColor,
    isCollapsed: isCollapsed,
    filled: true,
    hintText: "address".localeValue(context: context),
    hintStyle: TextStyle(
      fontFamily: context.isEnglish ? null : FontFamily.mainArabic,
      fontWeight: FontWeight.bold,
    ),
    prefixIcon: Icon(Icons.location_on_outlined, color: SwitchColor.primaryO),
    suffixIcon:
        Icon(Icons.keyboard_arrow_down_sharp, color: SwitchColor.primaryO),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: SwitchColor.primaryO),
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
    fillColor: SwitchColor.fillColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRaduis(10),
      borderSide: BorderSide(color: SwitchColor.primaryO),
    ),
    border: OutlineInputBorder(
      borderRadius: borderRaduis(10),
      borderSide: BorderSide(color: SwitchColor.primaryO),
    ),
    labelText: lableText,
    hintText: hintText,
  );
}
