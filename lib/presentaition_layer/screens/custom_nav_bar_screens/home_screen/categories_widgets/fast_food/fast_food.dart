import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/fast_food_demo_data.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/drinks/tab_bar_widgets/type_drinks.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
import 'package:provider/provider.dart';

class FastFoodCategoryWidget extends StatelessWidget {
  const FastFoodCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SearchingProvider>(
        builder: (context, searching, child) {
          return searching.searchingWithoutData
              ? const NotFounCategoryWidget(category: "fast_food")
              : Directionality(
                  textDirection: TextDirection.ltr,
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: context.screenHeight * .12,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: context.screenHeight * .467,
                    ),
                    itemCount: searching.filtred.length,
                    itemBuilder: (context, index) {
                      final FoodModel item = searching.filtred[index];
                      return GridFoodItem(
                        item: item,
                        onTap: () => pushTo(FoodDetials(item: item)),
                      );
                    },
                  ),
                );

          /*  searching.isItemNotExist
              ? const NotFounCategoryWidget(
                  category: "fast_food",
                )
              : Directionality(
                  textDirection: TextDirection.ltr,
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                      bottom: context.screenHeight * .09,
                      left: 6,
                      right: 6,
                    ),
                    itemCount: searching.isSearchingBarEmpty
                        ? fastFoodDemoData.length
                        : searching.filteredList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return searching.isSearchingBarEmpty
                                        ? FoodDetials(
                                            item: fastFoodDemoData[index],
                                          )
                                        : FoodDetials(
                                            item: searching.filteredList[index],
                                          );
                                  },
                                ),
                              );
                            },
                            child: FastFoodItemWidget(
                              index: index,
                              foodList: searching.isSearchingBarEmpty
                                  ? fastFoodDemoData
                                  : searching.filteredList,
                            ),
                          ),
                        ],
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: context.screenHeight * .467,
                      crossAxisSpacing: 17,
                      mainAxisSpacing: 10,
                    ),
                  ),
                ); */
        },
      ),
    );
  }
}
/* 
class FastFoodItemWidget extends StatelessWidget {
  const FastFoodItemWidget({
    super.key,
    /* required this.index,
    required this.foodList, */
    required this.item,
    required this.onTap,
  });

  /* final int index;
  final List<FoodModel> foodList; */

  final FoodModel item;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * .447,
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: SwitchColors.itemBackgoundColor,
      ),
      child: Clicker(
        onClick: onTap,
        raduis: 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: borderRaduis(20),
              child: Hero(
                tag: item.foodName,
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.fill,
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
                            item.foodName,
                            style: const TextStyle(
                              fontFamily: FontFamily.mainFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
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
                              "${item.foodPrice.toStringAsFixed(2)} \$",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ),
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
                              item.foodRate.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Color(0xFFF9F54B),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "(${item.numberOfReviewers.toString()}) reviewer",
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
                        item: item,
                      ),
                      const Icon(
                        Icons.add_circle,
                        color: Color(0xFF1F8A70),
                        size: 35,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */