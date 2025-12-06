import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/statemanagement/searching_system/searchin_drink_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/drinks/drinks_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
import 'package:provider/provider.dart';

class TypeDrinksWidget extends StatefulWidget {
  const TypeDrinksWidget({
    super.key,
    required this.typeDrinks,
  });
  final List<FoodModel> typeDrinks;

  @override
  State<TypeDrinksWidget> createState() => _TypeDrinksWidgetState();
}

class _TypeDrinksWidgetState extends State<TypeDrinksWidget> {
  @override
  void initState() {
    SearchingDrinksProvider searching =
        Provider.of<SearchingDrinksProvider>(context, listen: false);
    setState(() {
      searching.drinkList = widget.typeDrinks;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchingDrinksProvider>(
      builder: (context, searching, child) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 7,
            right: 7,
            top: 5,
          ),
          child: searching.isDrinkNotFound
              ? const NotFounCategoryWidget(
                  category: "drinks",
                )
              : Directionality(
                  textDirection: TextDirection.ltr,
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                      bottom: context.screenHeight * .07,
                    ),
                    itemCount: searching.isUserNotSearch
                        ? widget.typeDrinks.length
                        : searching.filteredDrinks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return searching.isUserNotSearch
                                        ? FastFoodDetailsScreen(
                                            item: widget.typeDrinks[index])
                                        : FastFoodDetailsScreen(
                                            item: searching
                                                .filteredDrinks[index]);
                                  },
                                ),
                              );
                            },
                            child: DrinkItemWidget(
                              index: index,
                              drinkList: searching.isUserNotSearch
                                  ? widget.typeDrinks
                                  : searching.filteredDrinks,
                            ),
                          ),
                        ],
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: context.screenHeight * .44,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class DrinkItemWidget extends StatelessWidget {
  const DrinkItemWidget({
    super.key,
    required this.drinkList,
    required this.index,
  });
  final int index;

  final List<FoodModel> drinkList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * .43,
      padding: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: SwitchColors.itemBackgoundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntrinsicWidth(
            child: SizedBox(
              height: context.screenHeight * .2,
              child: ClipRRect(
                borderRadius: borderRaduis(20),
                child: Hero(
                  tag: index.toString(),
                  child: Image.asset(
                    drinkList[index].imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: borderRaduis(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          drinkList[index].foodName,
                          style: typeNameTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: context.screenHeight * .04,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${drinkList[index].foodPrice.toStringAsFixed(2)} \$",
                            style: typePriceTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFF9F54B),
                          ),
                          Text(
                            drinkList[index].foodRate.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Color(0xFFF9F54B),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "   (${drinkList[index].numberOfReviewers.toString()}) reviewer",
                        style: const TextStyle(
                          fontFamily: FontFamily.subFont,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OrderButtonWidget(
                      item: drinkList[index],
                    ),
                    const Icon(
                      Icons.add_circle,
                      color: Color(0xFF1F8A70),
                      size: 35,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
