import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:foodapp/statemanagement/authantications/authentication_provider.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/presentaition_layer/auth/components/auth_social_media.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/presentaition_layer/auth/forget_password/foget_password.dart';
import 'package:foodapp/presentaition_layer/auth/sign_up/sign_up_main_screen.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  void initState() {
    AuthControllers.initLogInControllers();
    super.initState();
  }

  @override
  void dispose() {
    AuthControllers.disposeLogInControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale("en"),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              bottom: null,
              child: Container(
                height: context.screenHeight * .33,
                decoration: const BoxDecoration(
                  color: Color(0xFF082032),
                ),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    const Gap(hRatio: 0.05),
                    Padding(
                      padding: padding(10.0, from: From.horizontal),
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
                    const Gap(hRatio: 0.02),
                    const Text(
                      "LOG IN",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.mainFont,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(height: 10.0),
                    const Text(
                      "Please sign in to your existing account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: context.screenHeight * .3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRaduis(20.0, side: Side.top),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Gap(height: 20.0),
                      AuthField(
                        controller: AuthControllers.logEmailController!,
                        textInputType: TextInputType.emailAddress,
                        textFeildTitle: "Email",
                        hintText: "example@gmail.com",
                        /*  validator: (validate) {
                              if ((validate as String).isEmpty) {
                                return "This field can not be empty";
                              }
                              return null;
                            }, */
                      ),
                      const Gap(height: 30.0),
                      AuthField(
                        controller: AuthControllers.logPwsController!,
                        textInputType: TextInputType.text,
                        textFeildTitle: "Password",
                        hasObscure: true,
                        hintText: "Please enter password",
                        /* isObscure: userLogin.isObscure,
                            suffixIcon: IconButton(
                              onPressed: () {
                                userLogin.showLoginPassword;
                              },
                              icon: userLogin.obscureIcon,
                            ),
                            validator: (validate) {
                              if ((validate as String).isEmpty) {
                                return "This field can not be empty";
                              }
                              return null;
                            }, */
                      ),
                      const Gap(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Clicker(
                            onClick: () => pushTo(const ForgetPassWordScreen()),
                            child: const Text(
                              "Forgot password ?",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(hRatio: 0.03),
                      AuthButton(
                        buttonTitle: "LOG IN",
                        authantication: () async {
                          await context
                              .read<FireAuthProvider>()
                              .signInWithEmailAndPassword();
                          /* if (loginKey.currentState!.validate()) {
                                userLogin.signInWithEmailAndPassword(
                                  context: context,
                                );
                              } else {
                                showToastification(
                                  message: "Plsease enter the needed info",
                                  type: ToastificationType.error,
                                );
                              } */
                        },
                      ),
                      const Gap(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Don't have an account ?",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: FontFamily.mainFont,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              log("Get Sign in Screen");
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SignInMainScreen();
                                  },
                                ),
                                (route) {
                                  return false;
                                },
                              );
                            },
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontFamily.mainFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const AuthSocialMediaWidget(),
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
