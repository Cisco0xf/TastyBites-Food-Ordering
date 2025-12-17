import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
                    : const Icon(
                        key: ValueKey("ADD_KEY"),
                        Icons.add_circle,
                        color: Colors.orange,
                        size: 35.0,
                      ),
          ),
        );
      },
    );
  }
}

/* 
class AnimatedAddToCart extends StatefulWidget {
  const AnimatedAddToCart({
    super.key,
    required this.target,
  });

  final FoodModel target;

  @override
  State<AnimatedAddToCart> createState() => _AnimatedAddToCartState();
}

class _AnimatedAddToCartState extends State<AnimatedAddToCart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>().animate(_controller);

    super.initState();
  }

  Future<void> _animate() async {
    await _controller.forward();
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    final List<FoodModel> cartItems = context.watch<CartManager>().state;
    final bool isExist = cartItems.any((item) => item.id == widget.target.id);

    return Consumer<CartManager>(
      builder: (context, cart, _) {
        return Clicker(
          onClick: () async {
            await cart.addFoodItemToCart(widget.target);
            await _animate();
          },
          isCircular: true,
          child: ScaleTransition(
            scale: _animation,
            child: isExist
                ? const Icon(Icons.remove_circle)
                : const Icon(Icons.add_circle, color: Colors.orange),
          ),
        );
      },
    );
  }
} */
