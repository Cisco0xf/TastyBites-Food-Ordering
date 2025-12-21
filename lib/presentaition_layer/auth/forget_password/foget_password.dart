import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class ForgetPassWordScreen extends StatefulWidget {
  const ForgetPassWordScreen({super.key});

  @override
  State<ForgetPassWordScreen> createState() => _ForgetPassWordScreenState();
}

class _ForgetPassWordScreenState extends State<ForgetPassWordScreen> {
  @override
  void initState() {
    AuthControllers.initResetPwsEmailController();
    super.initState();
  }

  @override
  void dispose() {
    AuthControllers.diposeResetPwsEmailController();
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
                  SizedBox(
                    height: context.screenHeight * .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 35,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Forgot Password",
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Please Enter your existing account to get the code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.mainFont,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: context.screenHeight * .31,
            /*  bottom: 0,
                right: 0,
                left: 0, */
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRaduis(20.0, side: Side.top),
              ),
              child: Column(
                children: <Widget>[
                  const Gap(hRatio: 0.03),
                  AuthField(
                    controller: AuthControllers.resetPassworsEmail!,
                    textFeildTitle: "Email",
                    textInputType: TextInputType.emailAddress,
                    hintText: "example@gmail.com",
                    /* validator: (validate) {
                          if ((validate as String).isEmpty) {
                            return "This field can not be empty";
                          }
                          return null;
                        }, */
                  ),
                  const Gap(hRatio: 0.1),
                  AuthButton(
                    buttonTitle: "Send link",
                    authantication: () async {
                      await context
                          .read<FireAuthProvider>()
                          .sendResetPasswordEmail();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
