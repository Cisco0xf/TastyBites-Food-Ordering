import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/list_item.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/food_demo_data.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/desserts/desserts_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/add_icon_btn.dart';
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
    return Consumer<SearchingProvider>(
      builder: (context, searching, _) {
        if (searching.searchingWithoutData) {
          return const NotFounCategoryWidget();
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
                  item: item,
                  onTap: () {
                    pushTo(FoodDetails(item: item));
                  },
                );
              },
            ),
          ),
        );

        /* return searching.isItemNotExist
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
                        child: ListFoodItem(
                          index: index,
                          foodList: searching.isSearchingBarEmpty
                              ? italianFoodDemoData
                              : searching.filteredList,
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
