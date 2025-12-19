import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/style.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/components/profile_reusable_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/components/show_full_profile_image.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/components/show_log_out_dialog.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/personal_info_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/screens/receipts_history/receipt_history_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/screens/settings/settings.dart';
import 'package:provider/provider.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(15),
          ),
          color: SwitchColors.profileBackgroundColor,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: Consumer<PersonalInfoProvider>(
                builder: (context, personalInfo, child) {
                  return Column(
                    children: <Widget>[
                      Row(
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          const SizedBox(
                            child: ShowProfileImageWidget(
                              imagePath:
                                  "asstes/images/app_images/profile/profile.jpg",
                              child: Hero(
                                tag: "profile_image",
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    "asstes/images/app_images/profile/profile.jpg",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: <Widget>[
                                SizedBox(
                                  width: context.screenWidth * .6,
                                  child: Text(
                                    personalInfo.getCurrentUserName,
                                    textAlign: TextAlign.start,
                                    textDirection: TextDirection.ltr,
                                    style: const TextStyle(
                                      fontFamily: FontFamily.mainFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 5.0,
                                  ),
                                  margin: const EdgeInsets.only(
                                    right: 5,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: context.isLight
                                        ? const Color(0xFFFEECE2)
                                        : const Color(0xFF4c4744),
                                    borderRadius: borderRaduis(5),
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  child: const Text("BIO"),
                                ),
                                SizedBox(
                                  width: context.screenWidth * .6,
                                  child: Text(
                                    personalInfo.currentBIO,
                                    textAlign: TextAlign.start,
                                    textDirection: TextDirection.ltr,
                                    style: const TextStyle(
                                      fontFamily: FontFamily.subFont,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF9e9e9e),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: context.screenHeight * .01,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: borderRaduis(20),
                color: context.isLight
                    ? AppLightColors.profileItemsColor
                    : AppDarkColors.profileItemsColor,
              ),
              child: Column(
                children: <Widget>[
                  ProfileAvatar(
                    title: "personal_info".localeValue(context: context),
                    trailing: const Icon(
                      Icons.person_2_outlined,
                      color: Color(0xFFFF9800),
                    ),
                    targetWidget: const PersonalInfoScreen(),
                  ),
                  ProfileAvatar(
                    title: "settings".localeValue(context: context),
                    trailing: const Icon(
                      Icons.settings,
                      color: Color(0xFF303f9f),
                    ),
                    targetWidget: const SettingsMainWidget(),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: borderRaduis(20),
                color: context.isLight
                    ? AppLightColors.profileItemsColor
                    : AppDarkColors.profileItemsColor,
              ),
              child: Column(
                children: <Widget>[
                  ProfileAvatar(
                    title: "receipt_history".localeValue(context: context),
                    trailing: const Icon(
                      Icons.newspaper_rounded,
                      color: Color(0xFFECB159),
                    ),
                    targetWidget: const ReceiptHistoryWidget(),
                  ),
                  ProfileAvatar(
                    title: "number_of_orders".localeValue(context: context),
                    trailing: const Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.cyan,
                    ),
                    targetWidget: const ReceiptHistoryWidget(),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: borderRaduis(20),
                color: context.isLight
                    ? AppLightColors.profileItemsColor
                    : AppDarkColors.profileItemsColor,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: borderRaduis(10.0),
                  onTap: () async => await showLogoutDialog(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: context.isLight
                                ? Colors.white
                                : Colors.black45.withOpacity(0.5),
                            child: const Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "log_out".localeValue(context: context),
                            style: AppTextStyles.profileWidgetTextStyle(
                              context: context,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
