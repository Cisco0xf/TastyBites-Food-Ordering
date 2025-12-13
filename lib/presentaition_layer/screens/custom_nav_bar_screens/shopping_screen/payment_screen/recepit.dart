import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/receipt_management/receipt_history_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:foodapp/presentaition_layer/screens/main_screen/main_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RecepitWidget extends StatelessWidget {
  const RecepitWidget({
    super.key,
    required this.isSingleItem,
  });
  final bool isSingleItem;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartManager>(
      builder: (context, clearCart, child) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) async {
            if (!isSingleItem) {
              await clearCart.clearCart();
            }
          },
          child: Scaffold(
            body: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: context.screenHeight * .05,
                  ),
                  height: context.screenHeight * .13,
                  decoration: BoxDecoration(
                    color: SwitchColors.receiptAppBarColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () async {
                          if (!isSingleItem) {
                            await clearCart.clearCart();
                          }
                          Navigator.of(navigationKey.currentContext!)
                              .pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return const MainScreen();
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        width: context.screenWidth * .12,
                      ),
                      const Text(
                        "Order Recepit",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Consumer<PlaceProvider>(
                          builder: (context, orderPlace, child) {
                            return SizedBox(
                              width: context.screenWidth * .8,
                              height: context.screenHeight * .25,
                              child: orderPlace.isTakeaway
                                  ? Lottie.asset(
                                      "asstes/animations/delivary.json",
                                    )
                                  : Lottie.asset(
                                      "asstes/animations/making_food.json",
                                    ),
                            );
                          },
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            width: double.infinity,
                            padding: padding(10),
                            margin: padding(10),
                            decoration: BoxDecoration(
                              borderRadius: borderRaduis(7),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                              color: SwitchColors.receiptColor,
                            ),
                            child: Consumer<ManageReceiptHistory>(
                              builder: (context, lastSavedReceipt, child) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          "Ordered in :",
                                          style: TextStyle(
                                            fontFamily: FontFamily.mainFont,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: padding(7),
                                          margin: padding(5),
                                          decoration: BoxDecoration(
                                            borderRadius: borderRaduis(10),
                                            color: SwitchColors.dateBoxColor,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Text(
                                            lastSavedReceipt
                                                .state.last.dateTime,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      lastSavedReceipt.state.last.newReceipt,
                                      style: const TextStyle(
                                        fontFamily: FontFamily.mainFont,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        /*  Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            /* SizedBox(
                              width: context.screenWidth * .8,
                              height: context.screenHeight * .08,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: borderRaduis(15),
                                ),
                                color: const Color(0xFFA9B388),
                                child: const Text("Track you order"),
                              ),
                            ), 
                            SizedBox(
                              height: context.screenHeight * .08,
                            ),*/
                          ],
                        ), */
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
