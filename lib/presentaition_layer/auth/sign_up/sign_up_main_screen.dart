// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/presentaition_layer/auth/log_in/log_in_main_screen.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class SignInMainScreen extends StatefulWidget {
  const SignInMainScreen({super.key});

  @override
  State<SignInMainScreen> createState() => _SignInMainScreenState();
}

class _SignInMainScreenState extends State<SignInMainScreen> {
  /* final GlobalKey<FormState> signUpKey = GlobalKey<FormState>(); */

  @override
  void initState() {
    AuthControllers.initCreateAccoutnControllers();
    super.initState();
  }

  @override
  void dispose() {
    AuthControllers.disposeCreateAccoutnControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            bottom: null,
            child: Container(
              height: context.screenHeight * .33,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF082032),
              ),
              child: Column(
                children: <Widget>[
                  const Gap(hRatio: 0.05),
                  Padding(
                    padding: padding(10.0, from: From.horizontal),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            popScreen();
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
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.mainFont,
                    ),
                  ),
                  const Gap(height: 10.0),
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
          Positioned.fill(
            top: context.screenHeight * .31,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                borderRadius: borderRaduis(20.0, side: Side.top),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const Gap(hRatio: 0.03),
                    AuthField(
                      controller: AuthControllers.username!,
                      textFeildTitle: "User name",
                      textInputType: TextInputType.name,
                      hintText: "Enter user name",
                    ),
                    const Gap(height: 15.0),
                    const Gap(height: 15.0),
                    AuthField(
                      controller: AuthControllers.emailController!,
                      textFeildTitle: "Email",
                      textInputType: TextInputType.emailAddress,
                      hintText: "example@gmail.com",
                    ),
                    const Gap(height: 15.0),
                    AuthField(
                      controller: AuthControllers.pswController!,
                      textFeildTitle: "Password",
                      textInputType: TextInputType.text,
                      hasObscure: true,
                      hintText: "Enter strong password",
                    ),
                    const Gap(height: 15.0),
                    AuthField(
                      controller: AuthControllers.rePwsController!,
                      textFeildTitle: "Re-enter password",
                      textInputType: TextInputType.text,
                      hasObscure: true,
                      hintText: "Re-enter password",
                    ),
                    const Gap(height: 20.0),
                    AuthButton(
                      buttonTitle: "SIGN UP",
                      authantication: () async {
                        await context
                            .read<FireAuthProvider>()
                            .createNewAccountWithEmailAndPassword();
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
                            pushTo(const LogInScreen(), type: Push.clear);
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
                    const Gap(hRatio: 0.09),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
