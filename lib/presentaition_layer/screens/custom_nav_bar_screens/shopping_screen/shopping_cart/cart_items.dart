import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/desserts/desserts_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_details_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/components/details_of_dishes.dart';
import 'package:provider/provider.dart';

import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/price_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/remove_item_from_cart.dart';

class CartItemsWidget extends StatefulWidget {
  const CartItemsWidget({super.key});

  @override
  State<CartItemsWidget> createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  Map<String, Widget> _pushTarget(FoodModel item) {
    return {
      "FastFood": FastFoodDetailsScreen(item: item),
      "Dessert": DessertsDetailsWidget(item: item),
      "ColdDrink": FastFoodDetailsScreen(item: item),
      "HotDrink": FastFoodDetailsScreen(item: item),
      "SpecialFood": FastFoodDetailsScreen(item: item),
      "GlobalDishe": GlobalDishesDetailsWidget(item: item),
      "Salad": ShowDishesDetailsWidget(item: item),
      "Vegetarian": ShowDishesDetailsWidget(item: item),
      "Sushi": FastFoodDetailsScreen(item: item),
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
                  return GestureDetector(
                    onTap: () {
                      final FoodModel item = cartInfo.state[index];
                      pushTo(_pushTarget(item)[item.foodType]!);
                    },
                    child: CartItemWidget(
                      index: index,
                      foodList: cartInfo.state,
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

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.index,
    required this.foodList,
    required this.increaseQuantity,
    required this.decreaseQuantity,
  });

  final int index;
  final List<FoodModel> foodList;
  final void Function()? increaseQuantity;
  final void Function()? decreaseQuantity;

  String get _rate => double.parse(
        foodList[index].foodRate.toString(),
      ).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(15),
        color: SwitchColors.cartItemColor,
      ),
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              SizedBox(
                width: context.screenWidth * .32,
                height: context.screenHeight * .15,
                child: ClipRRect(
                  borderRadius: borderRaduis(5),
                  child: Image.asset(
                    foodList[index].imagePath,
                    fit: BoxFit.cover,
                  ),
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
                        foodList[index].foodName,
                        style: const TextStyle(
                          fontFamily: FontFamily.mainFont,
                          fontSize: 16,
                        ),
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
                            foodList[index].foodPrice.toString(),
                          ).toStringAsFixed(2)} \$",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: context.screenWidth * .05,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 7,
                            right: 7,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: borderRaduis(7),
                            border: Border.all(
                              color: const Color(0xFFe0e0e0),
                              width: 1,
                            ),
                          ),
                          // Deterimain the quantity
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: decreaseQuantity,
                                child: const Icon(Icons.remove),
                              ),
                              Container(
                                width: context.screenWidth * .09,
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFe0e0e0),
                                  ),
                                  borderRadius: borderRaduis(5),
                                ),
                                child: Center(
                                  child: Text(
                                    foodList[index].stock.toString(),
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
          RemoveItemFromCartWidget(
            item: foodList[index],
          ),
        ],
      ),
    );
  }
}
