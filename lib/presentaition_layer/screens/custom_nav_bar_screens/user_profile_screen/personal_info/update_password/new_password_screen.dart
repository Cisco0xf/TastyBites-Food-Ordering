// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> resetPasswordKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PersonalInfoProvider>(
        builder: (context, resetPassword, child) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: context.screenHeight * .05,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth * .15,
                  ),
                  const Text(
                    "Reset password",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: context.screenHeight * .03,
              ),
              SizedBox(
                width: context.screenWidth * .7,
                height: context.screenHeight * .23,
                child: SvgPicture.asset(
                  "asstes/images/app_images/auth/update_password.svg",
                ),
              ),
              SizedBox(
                height: context.screenHeight * .03,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: resetPasswordKey,
                        child: Column(
                          children: <Widget>[
                            CustomTextFeildWidget(
                              controller: resetPassword.enterNewPassword,
                              textFeildTitle: "Enter new password",
                              textInputType: TextInputType.emailAddress,
                              hintText: "New password",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This feild can not be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: context.screenHeight * .04,
                            ),
                            CustomTextFeildWidget(
                              controller: resetPassword.enterConfirmPassword,
                              textFeildTitle: "Confirm password",
                              textInputType: TextInputType.emailAddress,
                              hintText: "confrim new password",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This feild can not be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.screenHeight * .06,
                      ),
                      SizedBox(
                        width: context.screenWidth * .6,
                        height: context.screenHeight * .08,
                        child: MaterialButton(
                          onPressed: () async {
                            if (resetPasswordKey.currentState!.validate()) {
                              resetPassword.saveNewPassword(context: context);
                            } else {
                              log("Something goes wrong while save new password");
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRaduis(20),
                          ),
                          color: const Color(0xFF8DECB4),
                          child: const Text("Save new password"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
