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

class FavoriteItemsScreen extends StatelessWidget {
  const FavoriteItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FoodModel> favItem =
        context.watch<WishListProvider>().favoriteItems;

    final bool empty = favItem.isEmpty;
    return Expanded(
      child: empty
          ? const EmptyFavorite()
          : Container(
              decoration: BoxDecoration(
                borderRadius: borderRaduis(15, side: Side.top),
                color: SwitchColor.bgColor,
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: context.screenHeight * .13),
                itemCount: favItem.length,
                itemBuilder: (context, index) {
                  final FoodModel item = favItem[index];
                  return FavoriteItemWidget(
                    item: item,
                    discover: () {
                      pushTo(customRouts(item));
                    },
                  );
                },
              ),
            ),
    );
  }
}
