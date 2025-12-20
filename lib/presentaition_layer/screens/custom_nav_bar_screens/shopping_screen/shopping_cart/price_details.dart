import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/style.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/chick_out.dart';
import 'package:provider/provider.dart';

class PriceDetailsWidget extends StatelessWidget {
  const PriceDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double discount = context.watch<CartManager>().disCount;
    final double totalPrice = context.watch<CartManager>().getTotlaPrice;
    final double orderAfter =
        context.watch<CartManager>().orderTotlAfterDiscount;
    return Container(
      width: context.screenWidth,
      height: context.screenHeight * .24,
      padding: padding(10),
      margin: padding(10.0),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(15),
        color: SwitchColor.primaryO.withOpacity(0.2),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "price_details".localeValue(context: context),
                style: TextStyle(
                  fontSize: 17,
                  color: SwitchColor.txtColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: context.isEnglish
                      ? FontFamily.mainFont
                      : FontFamily.mainArabic,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "totle_price".localeValue(context: context),
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: context.isEnglish
                      ? FontFamily.subFont
                      : FontFamily.mainArabic,
                ),
              ),
              Text(
                "\$ $totalPrice",
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: FontFamily.subFont,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "totle_discount".localeValue(context: context),
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: context.isEnglish
                      ? FontFamily.subFont
                      : FontFamily.mainArabic,
                ),
              ),
              Text(
                "\$ $discount",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: context.isEnglish
                      ? FontFamily.subFont
                      : FontFamily.mainArabic,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "order_totle".localeValue(context: context),
                style: TextStyle(
                  fontSize: 15,
                  color: SwitchColor.txtColor,
                  fontFamily: context.isEnglish
                      ? FontFamily.mainFont
                      : FontFamily.mainArabic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$ $orderAfter",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const Divider(),
          SizedBox(
            width: context.screenWidth * .8,
            height: context.screenHeight * .055,
            child: MaterialButton(
              onPressed: () {
                pushTo(const ChickOutWidget(isSingleItem: false));
              },
              shape: ContinuousRectangleBorder(
                borderRadius: borderRaduis(15),
              ),
              color: Colors.orange,
              child: Text(
                "chickout".localeValue(context: context),
                style: AppTextStyles.chickoutButtonTextStyle(context: context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
