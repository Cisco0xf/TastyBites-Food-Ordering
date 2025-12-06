import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:provider/provider.dart';

class UpdateUserPasswordScreen extends StatefulWidget {
  const UpdateUserPasswordScreen({super.key});

  @override
  State<UpdateUserPasswordScreen> createState() =>
      _UpdateUserPasswordScreenState();
}

class _UpdateUserPasswordScreenState extends State<UpdateUserPasswordScreen> {
  final GlobalKey<FormState> resePasswordKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PersonalInfoProvider>(
        builder: (context, updatePassword, child) {
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
                      Icons.arrow_back_ios_new,
                      color: Colors.orange,
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth * .15,
                  ),
                  const Text(
                    "Confirm account",
                    style: TextStyle(
                      fontSize: 23,
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
                height: context.screenHeight * .3,
                child: SvgPicture.asset(
                  "asstes/images/app_images/auth/confirm_user.svg",
                ),
              ),
              SizedBox(
                height: context.screenHeight * .02,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: resePasswordKey,
                        child: Column(
                          children: <Widget>[
                            CustomTextFeildWidget(
                              controller: updatePassword.resetEmailController,
                              textFeildTitle: "Email",
                              textInputType: TextInputType.emailAddress,
                              hintText: "Enter your email",
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This feild can not be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: context.screenHeight * .04,
                            ),
                            CustomTextFeildWidget(
                              controller:
                                  updatePassword.resetPasswordController,
                              textFeildTitle: "Password",
                              textInputType: TextInputType.emailAddress,
                              hintText: "Enter password",
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This feild can not be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.screenHeight * .05,
                      ),
                      SizedBox(
                        width: context.screenWidth * .7,
                        height: context.screenHeight * .07,
                        child: MaterialButton(
                          onPressed: () {
                            if (resePasswordKey.currentState!.validate()) {
                              updatePassword.reAuthenticateToResetPassword(
                                context: context,
                              );
                            } else {
                              log("Something goes wrong !!!");
                            }
                          },
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRaduis(20),
                          ),
                          child: const Text("Confirm"),
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
