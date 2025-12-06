import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/presentaition_layer/auth/log_in/log_in_main_screen.dart';
import 'package:foodapp/presentaition_layer/auth/sign_up/sign_up_main_screen.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:provider/provider.dart';

class PushAuthScreen extends StatelessWidget {
  const PushAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, isLoadding, child) {
          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  child: Image.asset(
                    "asstes/images/app_images/auth/main_BG.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: context.screenHeight * .2,
                left: 0,
                right: 0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 2,
                    tileMode: TileMode.clamp,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * .12,
                    ),
                    height: context.screenHeight * .3,
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.3),
                      borderRadius: borderRaduis(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AuthButtonWidget(
                          pushAuth: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SignInMainScreen();
                                },
                              ),
                            );
                          },
                          authTitle: "SIGN UP",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthButtonWidget(
                          pushAuth: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LogInScreen();
                                },
                              ),
                            );
                          },
                          authTitle: "LOG IN",
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: context.screenHeight * .2,
                right: 0,
                left: 0,
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Welcome to TastyBites",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(
                        height: context.screenHeight * .03,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: "Please ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: "SIGN UP",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: " to create new accaount OR ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: "LOG IN",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: " with your existing account",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
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

typedef Authantication = void Function()?;

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    super.key,
    required this.pushAuth,
    required this.authTitle,
  });

  final Authantication pushAuth;
  final String authTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * .6,
      height: context.screenHeight * .07,
      child: MaterialButton(
        onPressed: pushAuth,
        shape: RoundedRectangleBorder(
          borderRadius: borderRaduis(20),
        ),
        color: Colors.orange,
        child: Text(
          authTitle,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
