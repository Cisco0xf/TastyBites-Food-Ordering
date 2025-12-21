
import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/authantications/auth_operations.dart';
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
                  Column(
                    children: [
                      AuthField(
                        controller: AuthControllers.reauthEmail!,
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
                        controller: AuthControllers.reauthPws!,
                        hasObscure: true,
                        hintText: "Password",
                        textFeildTitle: "Enter password",
                        textInputType: TextInputType.text,
                       
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.screenHeight * .1,
                  ),
                  SizedBox(
                    width: context.screenWidth * .8,
                    height: context.screenHeight * .09,
                    child: MaterialButton(
                      onPressed: () async {
                        // Re-Authenticate here
                        await context
                            .read<AuthOperations>()
                            .reauthenticateCurrentUserForCriticalAction(
                          actionAfterReauthenticate: () {
                            showDeleteAccountDialog(context);
                          },
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRaduis(20),
                      ),
                      color: const Color(0xFFDDDDDD),
                      child: context.watch<AuthOperations>().isOperating
                          ? const Center(child: CircularProgressIndicator())
                          : const Text(
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
      child: MaterialButton(
        onPressed: () async {
          await context.read<AuthOperations>().deleteCurrentUser();
        },
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: borderRaduis(10),
        ),
        child: const Text("Delete"),
      ),
    );
  }
}

Future<void> showDeleteAccountDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: padding(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Delete Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(height: 20),
              const Text(
                "You are about to delete your account for ever, are sure about that ??",
                textAlign: TextAlign.center,
              ),
              const Gap(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("CANCEL"),
                  ),
                  const DeleteButtonWidget(),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
