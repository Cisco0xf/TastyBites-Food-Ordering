import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/screens/settings/localization/localization_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/screens/settings/theme/theme_widget.dart';

class SettingsMainWidget extends StatelessWidget {
  const SettingsMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "app_settings".localeValue(context: context),
            style: TextStyle(
              fontSize: 24,
              fontFamily: context.isEnglish
                  ? FontFamily.mainFont
                  : FontFamily.mainArabic,
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          ExplainWidget(
            title: "theme".localeValue(context: context),
            titleFlex: 2,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: borderRaduis(15),
              color: context.isLight
                  ? AppLightColors.profileItemsColor
                  : AppDarkColors.profileItemsColor,
            ),
            child: const ThemeWidget(),
          ),
          ExplainWidget(
            title: "language".localeValue(context: context),
            titleFlex: context.isEnglish ? 3 : 2,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: borderRaduis(15),
              color: context.isLight
                  ? AppLightColors.profileItemsColor
                  : AppDarkColors.profileItemsColor,
            ),
            child: const LanguageWidget(),
          ),
        ],
      ),
    );
  }
}

class ExplainWidget extends StatelessWidget {
  const ExplainWidget({
    super.key,
    required this.title,
    required this.titleFlex,
  });
  final String title;
  final int titleFlex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          flex: 1,
          child: Divider(
            endIndent: 10,
          ),
        ),
        Expanded(
          flex: titleFlex,
          child: Text(
            title,
            style: TextStyle(
              fontSize: context.isEnglish ? 17 : 20,
              fontFamily: context.isEnglish
                  ? FontFamily.mainFont
                  : FontFamily.mainArabic,
            ),
          ),
        ),
        const Expanded(
          flex: 7,
          child: Divider(),
        ),
      ],
    );
  }
}
