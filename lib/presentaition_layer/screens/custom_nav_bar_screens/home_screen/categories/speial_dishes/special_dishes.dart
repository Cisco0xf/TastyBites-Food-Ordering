import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/list_item.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/desserts/desserts_details.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';

import 'package:foodapp/common/app_dimention.dart';

import 'package:provider/provider.dart';

class SpecialDishesWidget extends StatelessWidget {
  const SpecialDishesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchingProvider>(
      builder: (context, searching, _) {
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
                  item: item,
                  onTap: () {
                    pushTo(FoodDetails(item: item));
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
