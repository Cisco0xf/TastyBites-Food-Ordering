import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/list_item.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';

import 'package:foodapp/common/app_dimention.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/salads_vegetarian/details_of_dishes.dart';
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
          return const EmptySearch();
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
      },
    );
  }
}
