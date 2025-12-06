import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';

typedef MainButton = void Function();

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    super.key,
    required this.buttonPropus,
    required this.onPressed,
  });
  final String buttonPropus;
  final MainButton onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * .92,
      height: context.screenHeight * .07,
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.black87,
        child: Text(
          buttonPropus,
          style: TextStyle(
            fontSize: context.isEnglish ? 20 : 22,
            color: Colors.white,
            fontFamily: context.isEnglish ? null : FontFamily.mainArabic,
          ),
        ),
      ),
    );
  }
}
