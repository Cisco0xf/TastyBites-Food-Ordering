import 'package:flutter/material.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/desserts_demo_data.dart';
import 'package:foodapp/data_layer/data_models/drinks_cold_demo_data.dart';
import 'package:foodapp/data_layer/data_models/fast_food_demo_data.dart';
import 'package:foodapp/data_layer/data_models/food_demo_data.dart';
import 'package:foodapp/data_layer/data_models/global_dishes_model.dart';
import 'package:foodapp/data_layer/data_models/salads_demo_data.dart';
import 'package:foodapp/data_layer/data_models/sushi_demo_data.dart';
import 'package:foodapp/data_layer/data_models/vegetarian_dishes.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/desserts/desserts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/drinks/drinks.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/fast_food.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_dishes.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/components/show_dishes.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/salads/salads.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/salads_vegetarian_widgets/vegetarian/vegetarian.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/speial_dishes/special_dishes.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/sushi/sushi_widget.dart';

class CategoriesItemsModel {
  final String itemTitle;
  final String itemImage;
  final Widget targetWidget;
  final List<FoodModel> filteredList;

  const CategoriesItemsModel({
    required this.itemTitle,
    required this.itemImage,
    required this.targetWidget,
    required this.filteredList,
  });
}

List<CategoriesItemsModel> categoriesItems = <CategoriesItemsModel>[
  CategoriesItemsModel(
    itemTitle: "fast_food",
    itemImage: "asstes/images/app_images/categories_images/fast_food.svg",
    targetWidget: const FastFoodCategoryWidget(),
    filteredList: fastFoodDemoData,
  ),
  CategoriesItemsModel(
    itemTitle: "drinks",
    itemImage: "asstes/images/app_images/categories_images/drinks.svg",
    targetWidget: const DrinksWidget(),
    filteredList: coldDrinksDemoData,
  ),
  CategoriesItemsModel(
    itemTitle: "special_dishes",
    itemImage: "asstes/images/app_images/categories_images/special_dishes.svg",
    targetWidget: const SpecialDishesWidget(),
    filteredList: italianFoodDemoData,
  ),
  CategoriesItemsModel(
    itemTitle: "salads",
    itemImage: "asstes/images/app_images/categories_images/salads.svg",
    targetWidget: const GreenDish() /* const SaladsTypeWidget() */,
    filteredList: saladDamoData,
  ),
  CategoriesItemsModel(
    itemTitle: "vegetarian",
    itemImage: "asstes/images/app_images/categories_images/vegetarians.svg",
    targetWidget: const GreenDish(),
    filteredList: vegetarianDishesDemoData,
  ),
  CategoriesItemsModel(
    itemTitle: "sushi",
    itemImage: "asstes/images/app_images/categories_images/sushi.svg",
    targetWidget: const SushiWidget(),
    filteredList: sushiDemoData,
  ),
  CategoriesItemsModel(
    itemTitle: "desserts",
    itemImage: "asstes/images/app_images/categories_images/desserts.svg",
    targetWidget: const DessertsWidget(),
    filteredList: dessertDemoData,
  ),
  CategoriesItemsModel(
    itemTitle: "global_dishes",
    itemImage: "asstes/images/app_images/categories_images/global_dishes.svg",
    targetWidget: const GlobalDishesWidget(),
    filteredList: globalDishesDemoData,
  ),
];
