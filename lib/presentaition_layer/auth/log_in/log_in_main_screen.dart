import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/presentaition_layer/auth/components/auth_wrapper.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:foodapp/presentaition_layer/auth/components/auth_social_media.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/presentaition_layer/auth/forget_password/foget_password.dart';
import 'package:foodapp/presentaition_layer/auth/sign_up/sign_up_main_screen.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

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
    return AuthWrapper(
      subTitle: "Please sign in to your existing account.",
      title: "LOG IN",
      children: [
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
            await context.read<FireAuthProvider>().signInWithEmailAndPassword();
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
    ) 
        ;
  }
}
