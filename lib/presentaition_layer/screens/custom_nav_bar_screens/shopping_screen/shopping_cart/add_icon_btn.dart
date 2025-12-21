import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:provider/provider.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key, required this.target});

  final FoodModel target;

  @override
  Widget build(BuildContext context) {
    final List<FoodModel> cartItems = context.watch<CartManager>().state;

    final bool isExist = cartItems.any((item) => item.id == target.id);

    return Consumer<CartManager>(
      builder: (context, cart, _) {
        return Clicker(
          onClick: () async {
            await cart.addFoodItemToFirestoreCart(target);
          },
          isCircular: true,
          innerPadding: 0.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: isExist
                ? const Icon(
                    key: ValueKey("REMOVE_KEY"),
                    Icons.remove_circle,
                    color: Colors.green,
                    size: 35.0,
                  )
                : Icon(
                    key: const ValueKey("ADD_KEY"),
                    Icons.add_circle,
                    color: SwitchColor.accent,
                    size: 35.0,
                  ),
          ),
        );
      },
    );
  }
}
