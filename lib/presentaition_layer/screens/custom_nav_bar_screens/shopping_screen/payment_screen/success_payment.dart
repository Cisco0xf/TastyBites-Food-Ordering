import 'package:flutter/material.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/payment_screen/recepit.dart';
import 'package:lottie/lottie.dart';

class SuccessfulPaymentWidget extends StatefulWidget {
  const SuccessfulPaymentWidget({
    super.key,
    required this.isSingleItem,
  });
  final bool isSingleItem;

  @override
  State<SuccessfulPaymentWidget> createState() =>
      _SuccessfulPaymentWidgetState();
}

class _SuccessfulPaymentWidgetState extends State<SuccessfulPaymentWidget>
    with TickerProviderStateMixin {
  late final AnimationController _successfulPaymentController;
  @override
  void initState() {
    _successfulPaymentController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(
      const Duration(milliseconds: 700),
      () {
        _successfulPaymentController.forward();
      },
    );

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(navigationKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return RecepitWidget(
                isSingleItem: widget.isSingleItem,
              );
            },
          ),
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _successfulPaymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: context.screenHeight * .05,
            ),
            height: context.screenHeight * .13,
            decoration: BoxDecoration(
              color: SwitchColors.successfulAppBarColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "successful_payment".localeValue(context: context),
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily:
                          context.isEnglish ? null : FontFamily.mainArabic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: context.screenHeight * .1,
                  ),
                  SizedBox(
                    width: context.screenWidth * .8,
                    height: context.screenHeight * .4,
                    child: Lottie.asset(
                      controller: _successfulPaymentController,
                      "asstes/animations/success_payment.json",
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * .02,
                  ),
                  Text(
                    "successful_payment".localeValue(context: context),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          context.isEnglish ? null : FontFamily.mainArabic,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * .05,
                  ),
                  Text(
                    "wait_receipt".localeValue(context: context),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily:
                          context.isEnglish ? null : FontFamily.mainArabic,
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * .09,
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
