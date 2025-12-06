import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';

class EmptyNotificationsWidget extends StatelessWidget {
  const EmptyNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: context.screenWidth * .8,
            height: context.screenHeight * .4,
            child: SvgPicture.asset(
              "asstes/images/app_images/notifications/empty_notification.svg",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: context.screenHeight * .01,
          ),
          Text(
            "no_notification".localeValue(context: context),
            style: context.isEnglish
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )
                : const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.mainArabic,
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "empty_notification".localeValue(context: context),
            textAlign: TextAlign.center,
            style: context.isEnglish
                ? const TextStyle(
                    fontSize: 14,
                  )
                : const TextStyle(
                    fontSize: 18,
                    fontFamily: FontFamily.mainArabic,
                  ),
          ),
        ],
      ),
    );
  }
}
