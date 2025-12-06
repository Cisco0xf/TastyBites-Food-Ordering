import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/presentaition_layer/auth/components/custom_auth_button.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/main_screen/main_screen.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            left: 0,
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Verification",
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
                  const Text(
                    "We have sent a code to your email",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamily.mainFont,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "example@gmail.com",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: FontFamily.mainFont,
                      fontWeight: FontWeight.bold,
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
                    height: context.screenHeight * .02,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Code",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Resend ",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "in.50 sec",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * .04,
                  ),
                  const Form(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          EnterCodeWidget(),
                          EnterCodeWidget(),
                          EnterCodeWidget(),
                          EnterCodeWidget(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * .1,
                  ),
                  CustomAuthButtonWidget(
                    buttonTitle: "Verify",
                    authantication: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return const MainScreen();
                          },
                        ),
                        (route) {
                          return false;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EnterCodeWidget extends StatelessWidget {
  const EnterCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * .15,
      height: context.screenHeight * .07,
      child: TextFormField(
        autofocus: true,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          fillColor: const Color(0xFFeceff1),
          filled: true,
          hintText: "_",
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRaduis(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRaduis(10),
            borderSide: const BorderSide(
              color: Colors.orange,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
