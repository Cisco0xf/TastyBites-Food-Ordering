import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
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
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale("en"),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      child: Scaffold(
        body: Consumer<AuthenticationProvider>(
          builder: (context, userLogin, child) {
            return Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: context.screenHeight * .33,
                    decoration: const BoxDecoration(
                      color: Color(0xFF082032),
                    ),
                    width: double.infinity,
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
                          "LOG IN",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.mainFont,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                Positioned(
                  top: context.screenHeight * .3,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: loginKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            AuthField(
                              controller: userLogin.loginEmailController,
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
                            const SizedBox(
                              height: 30,
                            ),
                            AuthField(
                              controller: userLogin.loginPasswordController,
                              textInputType: TextInputType.text,
                              textFeildTitle: "Password",
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: borderRaduis(10),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const ForgetPassWordScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Forgot password ?",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.screenHeight * .03,
                            ),
                            AuthButton(
                              buttonTitle: "LOG IN",
                              authantication: () {
                                if (loginKey.currentState!.validate()) {
                                  userLogin.signInWithEmailAndPassword(
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
                            const SizedBox(
                              height: 10,
                            ),
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
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
