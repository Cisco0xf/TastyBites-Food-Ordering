import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/desserts/desserts_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_details_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/components/details_of_dishes.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/price_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/remove_item_from_cart.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({super.key});

  Map<String, Widget> _pushTarget(FoodModel item) {
    return {
      "FastFood": FoodDetials(item: item),
      "Dessert": DessertsDetails(item: item),
      "ColdDrink": FoodDetials(item: item),
      "HotDrink": FoodDetials(item: item),
      "SpecialFood": FoodDetials(item: item),
      "GlobalDishe": GlobalDishesDetails(item: item),
      "Salad": ShowDishesDetailsWidget(item: item),
      "Vegetarian": ShowDishesDetailsWidget(item: item),
      "Sushi": FoodDetials(item: item),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartManager>(
      builder: (context, cartInfo, child) {
        return Column(
          children: [
            const PriceDetailsWidget(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: context.screenHeight * .1),
                itemCount: cartInfo.state.length,
                itemBuilder: (context, index) {
                  final FoodModel item = cartInfo.state[index];
                  return GestureDetector(
                    onTap: () {
                      pushTo(_pushTarget(item)[item.foodType]!);
                    },
                    child: CartItem(
                      /*   index: index,
                      foodList: cartInfo.state, */
                      item: item,
                      increaseQuantity: () {
                        cartInfo.increaseQnt(cartInfo.state[index]);
                      },
                      decreaseQuantity: () {
                        cartInfo.decreaseQnt(cartInfo.state[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.item,
    required this.increaseQuantity,
    required this.decreaseQuantity,
  });

  final FoodModel item;
  final void Function()? increaseQuantity;
  final void Function()? decreaseQuantity;

  String get _rate => double.parse(
        item.foodRate.toString(),
      ).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding(10),
      margin: padding(10),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(15),
        color: SwitchColor.cartItem,
        border: Border.all(color: SwitchColor.borderColor, width: 0.5),
      ),
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              SizedBox.square(
                dimension: context.screenHeight * .15,
                child: ClipRRect(
                  borderRadius: borderRaduis(5),
                  child: Image.asset(item.imagePath, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: context.screenWidth * .5,
                      child: Text(
                        item.foodName,
                        style: const TextStyle(
                            fontFamily: FontFamily.mainFont, fontSize: 16),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.star, color: Colors.yellow),
                        Text(_rate),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "${double.parse(
                            item.foodPrice.toString(),
                          ).toStringAsFixed(2)} \$",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(wRatio: 0.05),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 7.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: borderRaduis(7),
                            border: Border.all(
                              color: const Color(0xFFe0e0e0),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: decreaseQuantity,
                                child: const Icon(Icons.remove),
                              ),
                              Container(
                                width: context.screenWidth * .09,
                                padding: padding(5),
                                margin: padding(10.0, from: From.horizontal),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFe0e0e0),
                                  ),
                                  borderRadius: borderRaduis(5),
                                ),
                                child: Center(
                                  child: Text(
                                    item.stock.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: increaseQuantity,
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0.0,
            left: context.isEnglish ? null : 0.0,
            right: context.isEnglish ? 0.0 : null,
            child: Clicker(
              onClick: () async {
                await showRemoveCartItemDialog(context, item: item);
              },
              child: const Icon(Icons.close, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
