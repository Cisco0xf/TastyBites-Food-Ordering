// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/authantications/auth_operations.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  /* final GlobalKey<FormState> resetPasswordKey = GlobalKey<FormState>(); */
  @override
  void initState() {
    AuthControllers.initUpdatePwsController();
    super.initState();
  }

  @override
  void dispose() {
    AuthControllers.disposeUpdatePasswordControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Gap(hRatio: 0.05),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Colors.orange,
                ),
              ),
              const Gap(wRatio: 0.0156),
              const Text(
                "Reset password",
                style: TextStyle(
                  fontSize: 22,
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
                  const Gap(hRatio: 0.03),
                  SizedBox.square(
                    dimension: context.screenHeight * .23,
                    child: SvgPicture.asset(
                      "asstes/images/app_images/auth/update_password.svg",
                    ),
                  ),
                  const Gap(hRatio: 0.03),
                  Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          AuthField(
                            controller: AuthControllers.updatePws!,
                            textFeildTitle: "Enter new password",
                            textInputType: TextInputType.visiblePassword,
                            hasObscure: true,
                            hintText: "New password",
                          ),
                          const Gap(hRatio: 0.04),
                          AuthField(
                            controller: AuthControllers.reupdatePws!,
                            textFeildTitle: "Confirm password",
                            textInputType: TextInputType.visiblePassword,
                            hasObscure: true,
                            hintText: "confrim new password",
                          ),
                        ],
                      ),
                      const Gap(hRatio: 0.06),
                      SizedBox(
                        width: context.screenWidth * .6,
                        height: context.screenHeight * .08,
                        child: MaterialButton(
                          onPressed: () async {
                            await context
                                .read<AuthOperations>()
                                .updateCurrentUserPawwsord();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRaduis(20),
                          ),
                          color: const Color(0xFF8DECB4),
                          child: context.watch<AuthOperations>().isOperating
                              ? const Center(child: CircularProgressIndicator())
                              : const Text("Save new password"),
                        ),
                      ),
                    ],
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
