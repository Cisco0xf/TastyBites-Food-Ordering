import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/list_item.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/speial_dishes/special_dishes.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/style.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/components/details_of_dishes.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
import 'package:provider/provider.dart';

class GreenDish extends StatelessWidget {
  const GreenDish({
    super.key,
    /*   required this.typeList, */
  });

  /* final List<FoodModel> typeList; */

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchingProvider>(
      builder: (context, searching, child) {
        if (searching.searchingWithoutData) {
          return const NotFounCategoryWidget(
           
          );
        }

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: context.screenHeight * .12),
              itemCount: searching.filtred.length,
              itemBuilder: (context, index) {
                final FoodModel item = searching.filtred[index];

                return ListFoodItem(
                  isGreen: true,
                  item: item,
                  onTap: () {
                    pushTo(ShowDishesDetailsWidget(item: item));
                  },
                );
              },
            ),
          ),
        );
        /*  return searching.isItemNotExist
            ? NotFounCategoryWidget(
                category: context.read<CurrentIndexProvider>().currentIndex == 3
                    ? "salads"
                    : "vegetarian",
              )
            : Directionality(
                textDirection: TextDirection.ltr,
                child: Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: context.screenHeight * .12,
                    ),
                    itemCount: searching.isSearchingBarEmpty
                        ? typeList.length
                        : searching.filteredList.length,
                    itemBuilder: (context, index) {
                      return Clicker(
                        onClick: () {
                          final FoodModel food = searching.isSearchingBarEmpty
                              ? typeList[index]
                              : searching.filteredList[index];

                          pushTo(ShowDishesDetailsWidget(item: food));
                        },
                        child: GreenItemWidget(
                          typeList: searching.isSearchingBarEmpty
                              ? typeList
                              : searching.filteredList,
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
              ); */
      },
    );
  }
}
/* 
class GreenItemWidget extends StatelessWidget {
  const GreenItemWidget({
    super.key,
    required this.typeList,
    required this.index,
  });

  final int index;

  final List<FoodModel> typeList;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * .2,
      ),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: SwitchColors.greenItemColor,
      ),
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
                child: Hero(
                  tag: index.toString(),
                  child: Image.asset(
                    typeList[index].imagePath,
                    fit: BoxFit.cover,
                  ),
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
                    Text(
                      typeList[index].foodName,
                      style: typeNameTextStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${typeList[index].foodPrice.toString()} \$",
                      style: typePriceTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star,
                      color: Color(0xFFffeb3b),
                    ),
                    Text(
                      typeList[index].foodRate.toString(),
                      style: const TextStyle(
                        color: Color(0xFFffeb3b),
                      ),
                    ),
                    SizedBox(
                      width: context.screenWidth * .02,
                    ),
                    Text(
                        "   (${typeList[index].numberOfReviewers.toString()}) reviewers")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OrderButtonWidget(
                      item: typeList[index],
                      buttonColor: const Color(0xFF1b5e20),
                    ),
                    const Icon(
                      Icons.add_circle_outlined,
                      size: 30,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
 */

/// TODO:Clear this file after test