import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/cart_items.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/empty_cart_screen.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRaduis(15.0, side: Side.top),
          color: SwitchColors.shoppingBGColor,
        ),
        child: Consumer<CartManager>(
          builder: (context, cart, child) {
            final List<FoodModel> cartData = cart.state;

            if (cartData.isEmpty) {
              return const EmptyCartScreen();
            }

            return const CartItemsWidget();
          },
        ),
      ),
    );
  }
}
