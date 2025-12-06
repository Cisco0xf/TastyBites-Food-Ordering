import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class EmptyFavoriteWidget extends StatefulWidget {
  const EmptyFavoriteWidget({super.key});

  @override
  State<EmptyFavoriteWidget> createState() => _EmptyFavoriteWidgetState();
}

class _EmptyFavoriteWidgetState extends State<EmptyFavoriteWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: SwitchColors.backgroundMianColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: context.screenWidth * .7,
            height: context.screenHeight * .3,
            child: SvgPicture.asset(
              "asstes/images/app_images/screens_images/empty_favorite_screen.svg",
              fit: BoxFit.contain,
            ),
          ),
          Text(
            "empty_favorite".localeValue(context: context),
            style: TextStyle(
              fontSize: 20,
              fontFamily: context.isEnglish
                  ? FontFamily.mainFont
                  : FontFamily.mainArabic,
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
                "empty_favorite_sub_title".localeValue(
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
      ),
    );
  }
}
