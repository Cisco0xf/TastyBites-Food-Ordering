import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper(
      {super.key,
      required this.children,
      required this.subTitle,
      required this.title});

  final String title;
  final String subTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF082032),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: context.screenHeight * .31,
            child: Column(
              children: [
                const Gap(hRatio: 0.05),
                Padding(
                  padding: padding(10.0, from: From.horizontal),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          popScreen();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.orange,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(hRatio: 0.02),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.mainFont,
                  ),
                ),
                const Gap(height: 10.0),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: FontFamily.mainFont,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                borderRadius: borderRaduis(20.0, side: Side.top),
                color: SwitchColor.bgColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
