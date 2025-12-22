import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/grid_item.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/desserts/desserts_details.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';

import 'package:provider/provider.dart';

class FastFoodCategory extends StatelessWidget {
  const FastFoodCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SearchingProvider>(
        builder: (context, searching, child) {
          return searching.searchingWithoutData
              ? const EmptySearch()
              : Directionality(
                  textDirection: TextDirection.ltr,
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: context.screenHeight * .12,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: context.screenHeight * .42,
                    ),
                    itemCount: searching.filtred.length,
                    itemBuilder: (context, index) {
                      final FoodModel item = searching.filtred[index];
                      return GridFoodItem(
                        item: item,
                        onTap: () => pushTo(FoodDetails(item: item)),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
