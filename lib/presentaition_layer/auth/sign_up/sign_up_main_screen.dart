// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/authantications/authentication_provider.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/presentaition_layer/auth/log_in/log_in_main_screen.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SignInMainScreen extends StatefulWidget {
  const SignInMainScreen({super.key});

  @override
  State<SignInMainScreen> createState() => _SignInMainScreenState();
}

class _SignInMainScreenState extends State<SignInMainScreen> {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthenticationProvider>(
        builder: (context, userSignIn, child) {
          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: context.screenHeight * .33,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF082032),
                  ),
                  child: Column(
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.screenHeight * .02,
                      ),
                      const Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.mainFont,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Please SIGN UP to get start",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: FontFamily.mainFont,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: context.screenHeight * .31,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: signUpKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: context.screenHeight * .03,
                          ),
                          CustomTextFeildWidget(
                            controller: userSignIn.userNameControler,
                            textFeildTitle: "User name",
                            textInputType: TextInputType.name,
                            hintText: "Enter user name",
                            validator: (validate) {
                              if ((validate as String).isEmpty) {
                                return "This field can not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextFeildWidget(
                            controller: userSignIn.emailController,
                            textFeildTitle: "Email",
                            textInputType: TextInputType.emailAddress,
                            hintText: "example@gmail.com",
                            validator: (validate) {
                              if ((validate as String).isEmpty) {
                                return "This field can not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextFeildWidget(
                            controller: userSignIn.passwordController,
                            textFeildTitle: "Password",
                            textInputType: TextInputType.text,
                            isObscure: userSignIn.isPaswrdObscured,
                            hintText: "Enter strong password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                userSignIn.showPassword;
                              },
                              icon: userSignIn.paswrdIcon,
                            ),
                            validator: (validate) {
                              if ((validate as String).isEmpty) {
                                return "This field can not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextFeildWidget(
                            controller: userSignIn.reEnterPasswordController,
                            textFeildTitle: "Re-enter password",
                            textInputType: TextInputType.text,
                            hintText: "Re-enter password",
                            isObscure: userSignIn.isRePaswrdObscured,
                            suffixIcon: IconButton(
                              onPressed: () {
                                userSignIn.showErEnterPassword;
                              },
                              icon: userSignIn.rePaswrdIcon,
                            ),
                            validator: (validate) {
                              if ((validate as String).isEmpty) {
                                return "This field can not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomAuthButtonWidget(
                            buttonTitle: "SIGN UP",
                            authantication: () {
                              if (signUpKey.currentState!.validate()) {
                                userSignIn.chickIsEverythingOk();
                                userSignIn.createAccountWithEmailAndPssword(
                                  context: context,
                                );
                              } else {
                                showToastification(
                                  message: "Plsease enter the needed info",
                                  type: ToastificationType.error,
                                );
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Already have an account ?",
                                style: TextStyle(
                                  fontFamily: FontFamily.mainFont,
                                  fontSize: 17,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const LogInScreen();
                                      },
                                    ),
                                    (route) {
                                      return false;
                                    },
                                  );
                                },
                                child: const Text(
                                  "LOG IN",
                                  style: TextStyle(
                                    fontFamily: FontFamily.mainFont,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: context.screenHeight * .09,
                          ),
                        ],
                      ),
                    ),
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
