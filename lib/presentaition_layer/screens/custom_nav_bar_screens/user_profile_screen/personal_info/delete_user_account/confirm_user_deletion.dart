import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class ConfirmUserScreen extends StatefulWidget {
  const ConfirmUserScreen({super.key});

  @override
  State<ConfirmUserScreen> createState() => _ConfirmUserScreenState();
}

class _ConfirmUserScreenState extends State<ConfirmUserScreen> {
  GlobalKey<FormState> deleteAccountKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PersonalInfoProvider>(
        builder: (context, deleteAccount, child) {
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.screenHeight * .05,
              ),
              const Text(
                "Log in to confirm",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.mainFont,
                ),
              ),
              SizedBox(
                height: context.screenHeight * .01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * .1,
                ),
                child: const Text(
                  "Please Enter the Log in information for you account to confirm deletion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.mainFont,
                    color: Color(0xFFB4B4B8),
                  ),
                ),
              ),
              SizedBox(
                height: context.screenHeight * .01,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: deleteAccountKey,
                        child: Column(
                          children: [
                            AuthField(
                              controller: deleteAccount.deleteEmailController,
                              hintText: "Email",
                              textFeildTitle: "Enter your email",
                             // isObscure: false,
                              textInputType: TextInputType.emailAddress,
                             /*  validator: (value) {
                                if (value!.isEmpty) {
                                  return "This feild can not be empty";
                                }
                                return null;
                              }, */
                            ),
                            SizedBox(
                              height: context.screenHeight * .03,
                            ),
                            AuthField(
                              controller:
                                  deleteAccount.deletePasswordController,
                              hintText: "Password",
                              textFeildTitle: "Enter password",
                              //isObscure: deleteAccount.isObscure,
                              textInputType: TextInputType.text,
                              /* suffixIcon: IconButton(
                                onPressed: () {
                                  deleteAccount.unbObscure();
                                },
                                icon: deleteAccount.obscureIcon,
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "This feild can not be empty";
                                }
                                return null;
                              }, */
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.screenHeight * .1,
                      ),
                      SizedBox(
                        width: context.screenWidth * .8,
                        height: context.screenHeight * .09,
                        child: MaterialButton(
                          onPressed: () {
                            if (deleteAccountKey.currentState!.validate()) {
                              deleteAccount.reauthenticateToDeleteAccount(
                                context: context,
                              );
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Delete Account"),
                                    content: const Text(
                                        "You are about to delete your account for ever, are sure about that ??"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("CANCEL"),
                                      ),
                                      const DeleteButtonWidget(),
                                    ],
                                  );
                                },
                              );
                            } else {
                              log("Not Valide !!");
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRaduis(20),
                          ),
                          color: const Color(0xFFDDDDDD),
                          child: const Text(
                            "Confirm Deletion",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
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

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * .4,
      height: context.screenHeight * .06,
      child: Consumer<PersonalInfoProvider>(
          builder: (context, fuckAccount, child) {
        return MaterialButton(
          onPressed: () {
            fuckAccount.deleteUserAccount(
              context: context,
            );
          },
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: borderRaduis(10),
          ),
          child: const Text("Delete"),
        );
      }),
    );
  }
}
