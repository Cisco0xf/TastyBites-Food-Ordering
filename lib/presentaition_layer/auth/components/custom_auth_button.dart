import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/authantications/authentication_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:provider/provider.dart';

typedef Auth = void Function()?;

class CustomAuthButtonWidget extends StatelessWidget {
  const CustomAuthButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.authantication,
    this.isSignIn = false,
  });

  final String buttonTitle;
  final Auth authantication;
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * .8,
      height: context.screenHeight * .08,
      child: MaterialButton(
        onPressed: authantication,
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: borderRaduis(10),
        ),
        child: Consumer<AuthenticationProvider>(
          builder: (context, loadding, child) {
            if (isSignIn) {
              // If the button for sign in return builder to change the state between user chlick and navigation
              return Text(
                buttonTitle,
                style: const TextStyle(
                  fontFamily: FontFamily.mainFont,
                  color: Colors.white,
                  fontSize: 17,
                ),
              );
            } else {
              return Text(
                buttonTitle,
                style: context.isEnglish
                    ? const TextStyle(
                        fontFamily: FontFamily.mainFont,
                        color: Colors.white,
                        fontSize: 17,
                      )
                    : const TextStyle(
                        fontSize: 18,
                        fontFamily: FontFamily.mainArabic,
                        color: Colors.white,
                      ),
              );
            }
          },
        ),
      ),
    );
  }
}
