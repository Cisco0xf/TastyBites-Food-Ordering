import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/food_demo_data.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/style.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
import 'package:provider/provider.dart';

class SpecialDishesWidget extends StatelessWidget {
  const SpecialDishesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchingSystemProvider>(
      builder: (context, searching, child) {
        return searching.isItemNotExist
            ? const NotFounCategoryWidget(
                category: "special_dishes",
              )
            : Directionality(
                textDirection: TextDirection.ltr,
                child: Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: context.screenHeight * .12,
                    ),
                    itemCount: searching.isSearchingBarEmpty
                        ? italianFoodDemoData.length
                        : searching.filteredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return searching.isSearchingBarEmpty
                                    ? FoodDetials(
                                        item: italianFoodDemoData[index],
                                      )
                                    : FoodDetials(
                                        item: searching.filteredList[index],
                                      );
                              },
                            ),
                          );
                        },
                        child: SpecailDishesWidget(
                          index: index,
                          foodList: searching.isSearchingBarEmpty
                              ? italianFoodDemoData
                              : searching.filteredList,
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}

class SpecailDishesWidget extends StatelessWidget {
  const SpecailDishesWidget({
    super.key,
    required this.index,
    required this.foodList,
  });

  final int index;
  final List<FoodModel> foodList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: SwitchColors.itemBackgoundColor,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IntrinsicHeight(
              child: SizedBox(
                width: context.screenWidth * .4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                  child: Image.asset(
                    foodList[index].imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: context.screenWidth * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.screenWidth * .45,
                        child: IntrinsicWidth(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  foodList[index].foodName,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.mainFont,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${foodList[index].foodPrice.toString()} \$",
                        style: typePriceTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const Icon(
                            Icons.star,
                            color: Color(0xFFFD841F),
                          ),
                          Text(
                            foodList[index].foodRate.toString(),
                            style: const TextStyle(
                              color: Color(0xFFFD841F),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: context.screenWidth * .03,
                      ),
                      Text(
                        "(${foodList[index].numberOfReviewers} reviewer)",
                        style: const TextStyle(
                          fontFamily: FontFamily.subFont,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OrderButtonWidget(
                        item: foodList[index],
                      ),
                      SizedBox(
                        width: context.screenWidth * .03,
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
            )
          ],
        ),
      ),
    );
  }
}
