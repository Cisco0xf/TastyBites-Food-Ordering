import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/order_single_item/order_single_item_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/details_row.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:provider/provider.dart';

class OrderSingleItemWidget extends StatelessWidget {
  const OrderSingleItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleItemProvider>(
      builder: (context, singleOrder, child) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "order_item".localeValue(context: context),
                style: TextStyle(
                  fontFamily: context.isEnglish
                      ? FontFamily.mainFont
                      : FontFamily.mainArabic,
                  fontSize: 21,
                ),
              ),
              const Gap(height: 10.0),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  padding: padding(10),
                  margin: padding(10.0, from: From.horizontal),
                  decoration: BoxDecoration(
                    borderRadius: borderRaduis(15),
                    color: SwitchColor.cartItem,
                    border: Border.all(color: SwitchColor.borderColor),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox.square(
                        dimension: context.screenHeight * .11,
                        child: ClipRRect(
                          borderRadius: borderRaduis(7),
                          child: Image.asset(
                            singleOrder.orderedItem.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: context.screenWidth * .56,
                              child: Text(
                                singleOrder.orderedItem.foodName,
                                style: const TextStyle(
                                  fontFamily: FontFamily.mainFont,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFE7B10A),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${singleOrder.orderedItem.foodRate}",
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "\$ ${singleOrder.orderedItem.foodPrice}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: padding(5),
                                  margin: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                    left: 20,
                                    right: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: borderRaduis(5),
                                    color: SwitchColor.fillColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          singleOrder.decreaseStock(
                                            context: context,
                                          );
                                        },
                                        child: const CircleAvatar(
                                          radius: 15,
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: padding(10.0,
                                            from: From.horizontal),
                                        margin: padding(10.0,
                                            from: From.horizontal),
                                        decoration: BoxDecoration(
                                          borderRadius: borderRaduis(5),
                                          border: Border.all(
                                            color: SwitchColor.borderColor,
                                          ),
                                        ),
                                        child: Text(
                                          "${singleOrder.orderedItem.stock}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          singleOrder.increaseStock();
                                        },
                                        child: const CircleAvatar(
                                          radius: 15,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const CheckDivider(),
              DetailsRow(
                detail: "offer_discount".localeValue(context: context),
                price: "\$ ${singleOrder.offerDiscout}",
              ),
              const CheckDivider(),
              Consumer<PlaceProvider>(
                builder: (context, orderPlace, child) {
                  return orderPlace.isTakeaway
                      ? DetailsRow(
                          detail: "delivary".localeValue(context: context),
                          price: "\$ 11",
                        )
                      : DetailsRow(
                          detail: "service".localeValue(context: context),
                          price: "\$ 5",
                        );
                },
              ),
              const CheckDivider(),
              DetailsRow(
                detail: "totle_price".localeValue(context: context),
                price:
                    "\$ ${singleOrder.getTotalPriceAfterDiscountAndService()}",
              )
            ],
          ),
        );
      },
    );
  }
}
