import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/custom_divider.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/details_row.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:provider/provider.dart';

class OrderAllCartWidget extends StatelessWidget {
  const OrderAllCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double totalPrice = context.watch<CartManager>().getTotlaPrice;
    final double discount = context.watch<CartManager>().disCount;
    final double totalAfter =
        context.watch<CartManager>().getOrderTotalArterDiscountAndService();
    return Consumer<PlaceProvider>(
      builder: (context, orderPlace, child) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "price_details".localeValue(context: context),
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: context.isEnglish
                        ? FontFamily.mainFont
                        : FontFamily.mainArabic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const CheckDivider(),
            DetailsRow(
              detail: "totle_price".localeValue(context: context),
              price: "\$ $totalPrice",
            ),
            const CheckDivider(),
            DetailsRow(
              detail: "totle_discount".localeValue(context: context),
              price: "\$ $discount",
            ),
            const CheckDivider(),
            DetailsRow(
              detail: orderPlace.isTakeaway
                  ? "delivary".localeValue(context: context)
                  : "service".localeValue(context: context),
              price: orderPlace.isTakeaway ? "\$ 11" : "\$ 5",
            ),
            const CheckDivider(),
            DetailsRow(
              detail: "order_totle".localeValue(context: context),
              price: "\$ $totalAfter",
              color: Colors.black,
            )
          ],
        );
      },
    );
  }
}
