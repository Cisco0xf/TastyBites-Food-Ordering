import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/cart_items.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/empty_cart_screen.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CartManager>(
        builder: (context, cart, child) {
          bool isEmpty = cart.state.isEmpty;
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              color: SwitchColors.shoppingBGColor,
            ),
            child: isEmpty ? const EmptyCartScreen() : const CartItemsWidget(),
          );
        },
      ),
    );
  }
}
