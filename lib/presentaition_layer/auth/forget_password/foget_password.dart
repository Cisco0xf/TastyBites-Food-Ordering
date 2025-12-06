import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/authantications/authentication_provider.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
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
  late TextEditingController emailController;
  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthenticationProvider>(
        builder: (context, forgetPassword, child) {
          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: context.screenHeight * .03,
                      ),
                      Form(
                        key: forgetPasswordKey,
                        child: CustomTextFeildWidget(
                          controller: forgetPassword.resetPasswordController,
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
                      ),
                      SizedBox(
                        height: context.screenHeight * .1,
                      ),
                      CustomAuthButtonWidget(
                        buttonTitle: "Send link",
                        authantication: () {
                          if (forgetPasswordKey.currentState!.validate()) {
                            forgetPassword.sentResetPasswordLink();
                            ReusableMethods.showAwesomDialog(
                              context: context,
                              description:
                                  "We have sent a link to your email to reset your password",
                              title: "Chick your eamil",
                              dialogType: DialogType.info,
                            );
                          }
                        },
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
