import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/authantications/auth_provider.dart';
import 'package:foodapp/statemanagement/authantications/authentication_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:provider/provider.dart';

typedef Auth = void Function()?;

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonTitle,
    required this.authantication,
  });

  final String buttonTitle;
  final Auth authantication;

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.watch<FireAuthProvider>().isLoading;

    return SizedBox(
      width: context.screenWidth * .8,
      height: context.screenHeight * .08,
      child: MaterialButton(
        onPressed: authantication,
        color: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: borderRaduis(10)),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Text(
                buttonTitle,
                style: const TextStyle(
                  fontFamily: FontFamily.mainFont,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
      ),
    );
  }
}
