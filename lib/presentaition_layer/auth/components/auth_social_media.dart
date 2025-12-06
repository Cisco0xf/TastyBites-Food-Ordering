import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/statemanagement/authantications/authentication_provider.dart';
import 'package:provider/provider.dart';

class AuthSocialMediaWidget extends StatelessWidget {
  const AuthSocialMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Expanded(
              child: Divider(
                indent: 45,
                endIndent: 5,
              ),
            ),
            Text(
              "OR",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Divider(
                indent: 5,
                endIndent: 45,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  log("LOG IN with FACEBOOK");
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  width: context.screenWidth * .13,
                  height: context.screenHeight * .07,
                  child: SvgPicture.asset(
                    "asstes/images/app_images/auth/facebook-logo.svg",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: context.screenWidth * .07,
            ),
            Consumer<AuthenticationProvider>(
              builder: (context, googleSignin, child) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      googleSignin.signInWithGoogle(
                        context: context,
                      );

                      log("LOG IN with GOOGLE");
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      width: context.screenWidth * .14,
                      height: context.screenHeight * .07,
                      child: Image.asset(
                        "asstes/images/app_images/auth/google.png",
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: context.screenWidth * .07,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  log("LOG IN with TWITTER");
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  width: context.screenWidth * .13,
                  height: context.screenHeight * .07,
                  child: SvgPicture.asset(
                    "asstes/images/app_images/auth/twitter-logo.svg",
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
