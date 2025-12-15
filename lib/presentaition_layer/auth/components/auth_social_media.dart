import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthSocialMediaWidget extends StatelessWidget {
  const AuthSocialMediaWidget({super.key});

  Widget _sideDivider(bool start) => Expanded(
        child: Divider(
          indent: start ? 45 : 5,
          endIndent: start ? 5 : 45,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Gap(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _sideDivider(true),
            const Text(
              "OR",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            _sideDivider(false)
          ],
        ),
        const Gap(height: 10.0),
        Clicker(
          onClick: () async {
            await context.read<FireAuthProvider>().signInWithGoogleAccount();
          },
          child: SizedBox.square(
            dimension: context.screenHeight * .07,
            child: Image.asset(Assets.googleSignIn),
          ),
        ),
      ],
    );
  }
}
