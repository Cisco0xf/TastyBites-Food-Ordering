import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/components/show_full_profile_image.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/components/change_user_info_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/components/show_confirm_dailog.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/delete_user_account/delete_account_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/update_password/update_password.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final GlobalKey<FormState> updateInfoKey = GlobalKey<FormState>();
  late final PersonalInfoProvider accountActions;
  @override
  void initState() {
    accountActions = Provider.of<PersonalInfoProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Consumer<PersonalInfoProvider>(
          builder: (context, userInfo, child) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: context.screenHeight * .05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.orange,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        width: context.screenWidth * .15,
                      ),
                      const Text(
                        "Personal Info",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.mainFont,
                        ),
                      ),
                      SizedBox(
                        width: context.screenWidth * .13,
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              31,
                              context.screenHeight * .1,
                              30,
                              0,
                            ),
                            items: <PopupMenuEntry<dynamic>>[
                              PopupMenuItem(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const UpdateUserPasswordScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.update,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "update_pass"
                                          .localeValue(context: context),
                                      style: context.isEnglish
                                          ? const TextStyle(
                                              fontFamily: FontFamily.mainFont,
                                            )
                                          : const TextStyle(
                                              fontFamily: FontFamily.mainArabic,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const DeleteUserAccountScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "delete_account"
                                          .localeValue(context: context),
                                      style: context.isEnglish
                                          ? const TextStyle(
                                              fontFamily: FontFamily.mainFont,
                                              color: Colors.red,
                                            )
                                          : const TextStyle(
                                              fontFamily: FontFamily.mainArabic,
                                              color: Colors.red,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: context.screenWidth * .5,
                  height: context.screenHeight * .2,
                  child: const Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ShowProfileImageWidget(
                        imagePath:
                            "asstes/images/app_images/profile/profile.jpg",
                        child: Hero(
                          tag: "profile_image",
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              "asstes/images/app_images/profile/profile.jpg",
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 40,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFFe0e0e0),
                          child: Icon(
                            Icons.camera_alt_outlined,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      userInfo.getCurrentUserName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: FontFamily.mainFont,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Text(
                  userInfo.getCurrerentUserEmail,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.mainFont,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: context.screenHeight * .04,
                ),
                Consumer<PersonalInfoProvider>(
                  builder: (context, updateInfo, child) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: updateInfoKey,
                          child: Column(
                            children: <Widget>[
                              ChangeUserInfoWidget(
                                controller:
                                    updateInfo.updateDisplayNameController,
                                feildTilte: "Re-name",
                                unFocuseFeild:
                                    updateInfo.isUpdateUserNameFocused,
                                onChange: (value) {
                                  log("Feild Value : $value");
                                },
                                unFocuse: () {
                                  updateInfo.focuseUnfocuse(
                                    context: context,
                                  );
                                },
                                validator: (vlaue) {
                                  if (updateInfo.updateDisplayNameController
                                      .text.isEmpty) {
                                    return "This feild can not be empty";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: context.screenHeight * .03,
                              ),
                              ChangeUserInfoWidget(
                                controller: updateInfo.bioController,
                                feildTilte: "BIO",
                                unFocuseFeild: updateInfo.isbioFocused,
                                onChange: (value) {
                                  log("Feild Value : $value");
                                },
                                unFocuse: () {
                                  updateInfo.isbioFocuse(context: context);
                                },
                                validator: (vlaue) {
                                  if (updateInfo.bioController.text.isEmpty) {
                                    return "This feild can not be empty";
                                  }
                                  return null;
                                },
                                maxLines: 4,
                                maxLength: 120,
                              ),
                              SizedBox(
                                height: context.screenHeight * .03,
                              ),
                              CustomAuthButtonWidget(
                                buttonTitle: "save_changes"
                                    .localeValue(context: context),
                                authantication: () {
                                  if (updateInfoKey.currentState!.validate() &&
                                      !updateInfo.chickUserUpdate) {
                                    showwConfirmUpdateDialog(
                                        gcontext: this.context);
                                  } else if (updateInfo.chickUserUpdate) {
                                    ReusableMethods.showtoastification(
                                      message: "nothing_changes"
                                          .localeValue(context: context),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
