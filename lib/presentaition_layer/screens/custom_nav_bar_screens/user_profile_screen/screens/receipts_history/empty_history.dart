import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';

class EmptyReceiptWidget extends StatelessWidget {
  const EmptyReceiptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: context.screenWidth * .8,
            height: context.screenHeight * .3,
            child: SvgPicture.asset(
              "asstes/images/app_images/chickout_place/receipt_history.svg",
            ),
          ),
          SizedBox(
            height: context.screenHeight * .04,
          ),
          Text(
            "empty_receipt".localeValue(context: context),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: context.isEnglish
                  ? FontFamily.mainFont
                  : FontFamily.mainArabic,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
