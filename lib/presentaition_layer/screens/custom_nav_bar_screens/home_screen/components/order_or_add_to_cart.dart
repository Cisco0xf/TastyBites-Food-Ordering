import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/order_single_item/order_single_item_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
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
        children: <Widget>[
          Consumer<CartManager>(
            builder: (context, addToCart, child) {
              final bool isExist =
                  addToCart.state.any((element) => element.id == item.id);
              return GestureDetector(
                onTap: () async {
                  await addToCart.addFoodItemToCart(item);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  height: context.screenHeight * .07,
                  width: context.screenWidth * .45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFFF785B),
                      width: 1,
                    ),
                    borderRadius: borderRaduis(20),
                    color: SwitchColors.addToCartBGColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      addToCart.state.contains(item)
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
                            ? "added_to_cart".localeValue(context: context)
                            : "add_to_cart".localeValue(context: context),
                        style: AppTextStyles.addToCartButtonTextStyle(
                            context: context),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: context.screenHeight * .07,
            width: context.screenWidth * .45,
            child: ClipRRect(
              borderRadius: borderRaduis(20),
              child: Consumer<OrderSingleItemProvider>(
                builder: (context, orderNow, child) {
                  return OrderButtonWidget(
                    item: item,
                    buttonColor: orderButtonColor,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
