// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/presentaition_layer/auth/components/auth_wrapper.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/presentaition_layer/auth/log_in/log_in_main_screen.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class SignInMainScreen extends StatefulWidget {
  const SignInMainScreen({super.key});

  @override
  State<SignInMainScreen> createState() => _SignInMainScreenState();
}

class _SignInMainScreenState extends State<SignInMainScreen> {
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
    return AuthWrapper(
      subTitle: "Please SIGN UP to get start",
      title: "SIGN UP",
      children: [
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
    );
  }
}
