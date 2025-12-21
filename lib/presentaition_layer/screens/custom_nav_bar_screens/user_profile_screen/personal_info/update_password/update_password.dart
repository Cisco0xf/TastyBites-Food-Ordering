
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/personal_info/update_password/new_password_screen.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/authantications/auth_operations.dart';
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
  @override
  void initState() {
    AuthControllers.initReauthControllers();
    super.initState();
  }

  @override
  void dispose() {
    AuthControllers.disposeReauthControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                  Column(
                    children: <Widget>[
                      AuthField(
                        controller: AuthControllers.reauthEmail!,
                        textFeildTitle: "Email",
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter your email",
                        /*   validator: (val) {
                              if (val!.isEmpty) {
                                return "This feild can not be empty";
                              }
                              return null;
                            }, */
                      ),
                      SizedBox(
                        height: context.screenHeight * .04,
                      ),
                      AuthField(
                        controller: AuthControllers.reauthPws!,
                        textFeildTitle: "Password",
                        hasObscure: true,
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter password",
                        /*  validator: (val) {
                              if (val!.isEmpty) {
                                return "This feild can not be empty";
                              }
                              return null;
                            }, */
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.screenHeight * .05,
                  ),
                  SizedBox(
                    width: context.screenWidth * .7,
                    height: context.screenHeight * .07,
                    child: MaterialButton(
                      onPressed: () async {
                        await context
                            .read<AuthOperations>()
                            .reauthenticateCurrentUserForCriticalAction(
                          actionAfterReauthenticate: () {
                            pushTo(const NewPasswordScreen());
                          },
                        );
                      },
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRaduis(20),
                      ),
                      child: context.watch<AuthOperations>().isOperating
                          ? const Center(child: CircularProgressIndicator())
                          : const Text("Confirm"),
                    ),
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
