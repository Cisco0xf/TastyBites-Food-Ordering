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
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/drinks/drinks_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/desserts/desserts_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/sushi/sushi_details_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_details_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/components/details_of_dishes.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/speial_dishes/special_dishes_details.dart';

class FavoriteItemsScreen extends StatelessWidget {
  const FavoriteItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<WishListProvider>(
        builder: (context, addToFavorite, child) {
          return addToFavorite.favoriteItems.isEmpty
              ? const EmptyFavoriteWidget()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRaduis(15, side: Side.top),
                    color: SwitchColors.backgroundMianColor,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: context.screenHeight * .1,
                    ),
                    itemCount: addToFavorite.favoriteItems.length,
                    itemBuilder: (context, index) {
                      final FoodModel item = addToFavorite.favoriteItems[index];
                      return FavoriteItemWidget(
                        /* foodName:
                            WishListProvider.favoriteItems[index].foodName,
                        imagePath: addToFavorite.favoriteItems[index].imagePath,
                        foodRate:
                            WishListProvider.favoriteItems[index].foodRate,
                        foodPrice: WishListProvider
                            .favoriteItems[index].foodPrice,
                        numberOfReviewers: WishListProvider
                            .favoriteItems[index].numberOfReviewers,
                        removedIndex: index, */
                        item: item,
                        discover: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                if (item.foodType == "FastFood") {
                                  return FoodDetials(
                                    /* imagePath: item.imagePath,
                                    foodName: item.foodName,
                                    foodPrice: item.foodPrice,
                                    description: item.description,
                                    numberOfReviewers: item.numberOfReviewers,
                                    heroTage: index.toString(),
                                    rate: item.foodRate,
                                    calories: item.calories, */
                                    item: item,
                                  );
                                } else if (item.foodType == "Dessert") {
                                  return DessertsDetails(
                                    /*  imagePath: item.imagePath,
                                    description: item.description,
                                    price: item.foodPrice,
                                    rate: item.foodRate,
                                    numberOfReviewers: item.numberOfReviewers,
                                    dessertName: item.foodName, */
                                    item: item,
                                  );
                                } else if (item.foodType == "ColdDrink" ||
                                    item.foodType == "HotDrink") {
                                  return FoodDetials(
                                    /*  imagePath: item.imagePath,
                                    drinkDescription: item.description,
                                    drinkName: item.foodName,
                                    heroTag: index.toString(),
                                    price: item.foodPrice,
                                    rate: item.foodRate,
                                    numberOfReviewers: item.numberOfReviewers, */
                                    item: item,
                                  );
                                } else if (item.foodType == "SpecialFood") {
                                  return FoodDetials(
                                    /*    imagePath: item.imagePath,
                                    price: item.foodPrice,
                                    specialDishNeme: item.foodName,
                                    heroTag: index,
                                    description: item.description,
                                    rate: item.foodRate,
                                    numberOfReviewers: item.numberOfReviewers, */
                                    item: item,
                                  );
                                } else if (item.foodType == "GlobalDishe") {
                                  return GlobalDishesDetails(
                                    /*   imagePath: item.imagePath,
                                    description: item.description,
                                    rate: item.foodRate,
                                    numberOfReviewers: item.numberOfReviewers, */
                                    item: item,
                                    /*  country: item.dishCountry,
                                    dishName: item.foodName,
                                    price: item.foodPrice,
                                    countryFlag: item.dishCountryFlag,
                                    targetIndex: index, */
                                  );
                                } else if (item.foodType == "Salad" ||
                                    item.foodType == "Vegetarian") {
                                  return ShowDishesDetailsWidget(
                                    /*  imagePath: item.imagePath,
                                    description: item.description,
                                    rate: item.foodRate,
                                    dishName: item.foodName,
                                    ingredientsImages: item.ingredientsImages,
                                    ingredientsNames: item.ingredientsNames,
                                    price: item.foodPrice,
                                    heroTag: index.toString(),
                                    numberOfReviewers: item.numberOfReviewers, */
                                    item: item,
                                  );
                                } else {
                                  return FoodDetials(
                                    /*  imagePath: item.imagePath,
                                    sushiName: item.foodName,
                                    sushiPrice: item.foodPrice,
                                    description: item.description,
                                    numberOfReviewers: item.numberOfReviewers,
                                    heroTag: index,
                                    sushiRate: item.foodRate,
                                    stock: item.stock, */
                                    item: item,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
