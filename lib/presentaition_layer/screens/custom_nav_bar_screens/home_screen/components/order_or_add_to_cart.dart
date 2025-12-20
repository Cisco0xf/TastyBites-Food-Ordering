import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/order_single_item/order_single_item_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class OrderOrAddtoCartWidget extends StatelessWidget {
  const OrderOrAddtoCartWidget({
    super.key,
    this.orderButtonColor = const Color(0xFFef6c00),
    required this.item,
  });

  final Color orderButtonColor;
  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Consumer<CartManager>(
            builder: (context, addToCart, child) {
              final bool isExist =
                  addToCart.state.any((element) => element.id == item.id);
              return ClipRRect(
                borderRadius: borderRaduis(30),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      //margin: padding(10, from: From.horizontal),

                      height: context.screenHeight * .07,
                      width: context.screenWidth * .45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFF785B),
                          width: 1,
                        ),
                        borderRadius: borderRaduis(30),
                        color: SwitchColor.borderColor,
                      ),
                      child: Clicker(
                        onClick: () async {
                          await addToCart.addFoodItemToFirestoreCart(item);
                        },
                        raduis: 30.0,
                        innerPadding: 10.0,
                        child: addToCart.isOperating
                            ? LoadingAnimationWidget.inkDrop(
                                color: Colors.orange,
                                size: 30.0,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  isExist
                                      ? const Icon(
                                          Icons.shopping_bag,
                                          color: Color(0xFFFF785B),
                                        )
                                      : const Icon(
                                          Icons.shopping_bag_outlined,
                                          color: Color(0xFFFF785B),
                                        ),
                                  Text(
                                    isExist
                                        ? "added_to_cart"
                                            .localeValue(context: context)
                                        : "add_to_cart"
                                            .localeValue(context: context),
                                    style:
                                        AppTextStyles.addToCartButtonTextStyle(
                                            context: context),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          OrderButtonWidget(
            item: item,
            buttonColor: orderButtonColor,
            height: context.screenHeight * 0.07,
            width: context.screenWidth * .45,
            raduis: 30.0,
          ),
        ],
      ),
    );
  }
}
