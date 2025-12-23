import 'package:flutter/material.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/presentaition_layer/auth/components/auth_wrapper.dart';
import 'package:foodapp/statemanagement/authantications/auth_controllers.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_text_feild.dart';
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
    return AuthWrapper(
      subTitle: "Please Enter your existing account to get the link",
      title: "Forgot Password",
      children: [
        const Gap(hRatio: 0.03),
        AuthField(
          controller: AuthControllers.resetPassworsEmail!,
          textFeildTitle: "Email",
          textInputType: TextInputType.emailAddress,
          hintText: "example@gmail.com",
        ),
        const Gap(hRatio: 0.1),
        AuthButton(
          buttonTitle: "Send link",
          authantication: () async {
            await context.read<FireAuthProvider>().sendResetPasswordEmail();
          },
        ),
      ],
    ) 
        ;
  }
}
