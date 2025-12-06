import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/constants/style.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/custom_nav_bar_widgets/content_widgets.dart';
import 'package:provider/provider.dart';

class MainScreenAppBar extends StatelessWidget {
  const MainScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.screenHeight * .05,
        bottom: 10,
        left: 10,
        right: 10,
      ),
      height: context.screenHeight * .12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Consumer<CurrentIndexProvider>(
            builder: (context, currentTilte, child) {
              return Text(
                contentWidgets[currentTilte.currentContent]
                    .widgetTitle
                    .localeValue(context: context),
                style: AppTextStyles.mainWidgetTextStyle(
                  context: context,
                ),
              );
            },
          ),
          Consumer<CurrentIndexProvider>(
            builder: (context, hitProfile, child) {
              return Visibility(
                visible: !(hitProfile.currentContent == 4),
                child: GestureDetector(
                  onTap: () {
                    hitProfile.switchContent(5);
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      "asstes/images/app_images/profile/profile.jpg",
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
