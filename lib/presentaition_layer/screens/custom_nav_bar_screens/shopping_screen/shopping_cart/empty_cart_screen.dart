import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: context.screenWidth * .8,
          height: context.screenHeight * .3,
          child: SvgPicture.asset(
            "asstes/images/app_images/screens_images/empty_cart.svg",
          ),
        ),
        SizedBox(
          height: context.screenHeight * .04,
        ),
        Text(
          "nothing_added_to_cart".localeValue(
            context: context,
          ),
          style: TextStyle(
            fontFamily:
                context.isEnglish ? FontFamily.coolFont : FontFamily.mainArabic,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            left: 8.0,
            top: 10,
          ),
          child: Opacity(
            opacity: 0.6,
            child: Text(
              "nothing_added_to_cart_sub_tilte".localeValue(
                context: context,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontFamily: context.isEnglish
                    ? FontFamily.mainFont
                    : FontFamily.mainArabic,
              ),
            ),
          ),
        ),
        Consumer<CurrentIndexProvider>(
          builder: (context, goToHome, child) {
            return Container(
              margin: EdgeInsets.only(
                top: context.screenHeight * .05,
              ),
              width: context.screenWidth * .4,
              height: context.screenHeight * .06,
              child: MaterialButton(
                onPressed: () {
                  goToHome.switchContent(1);
                },
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRaduis(20),
                ),
                child: Text(
                  "go_home".localeValue(context: context),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: context.isEnglish
                        ? FontFamily.mainFont
                        : FontFamily.mainArabic,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
