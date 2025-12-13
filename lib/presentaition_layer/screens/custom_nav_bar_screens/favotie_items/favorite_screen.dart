import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:provider/provider.dart';

import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/favotie_items/favorite_empty.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/favotie_items/item_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/desserts/desserts_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/components/details_of_dishes.dart';

class FavoriteItemsScreen extends StatelessWidget {
  const FavoriteItemsScreen({super.key});

  Widget _targetWidget(String key, FoodModel item) {
    final Widget defaultRout = FoodDetials(item: item);

    final Map<String, Widget> routs = {
      "FastFood": defaultRout,
      "Dessert": DessertsDetails(item: item),
      "Salad": ShowDishesDetailsWidget(item: item),
      "Vegetarian": ShowDishesDetailsWidget(item: item),
    };

    final Widget target = routs[key] ?? defaultRout;

    return target;
  }

  @override
  Widget build(BuildContext context) {
    final List<FoodModel> favItem =
        context.watch<WishListProvider>().favoriteItems;

    final bool empty = favItem.isEmpty;
    return Expanded(
      child: empty
          ? const EmptyFavoriteWidget()
          : Container(
              decoration: BoxDecoration(
                borderRadius: borderRaduis(15, side: Side.top),
                color: SwitchColors.backgroundMianColor,
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: context.screenHeight * .13),
                itemCount: favItem.length,
                itemBuilder: (context, index) {
                  final FoodModel item = favItem[index];
                  return FavoriteItemWidget(
                    item: item,
                    discover: () {
                      pushTo(_targetWidget(item.foodType, item));
                    },
                  );
                },
              ),
            ),
    );
  }
}
