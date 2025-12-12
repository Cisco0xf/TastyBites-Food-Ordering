import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/food_demo_data.dart';
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
          return const NotFounCategoryWidget(category: "special_dishes");
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
                    pushTo(FoodDetials(item: item));
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

class ListFoodItem extends StatelessWidget {
  const ListFoodItem({
    super.key,
    /* required this.index,
    required this.foodList, */
    required this.item,
    required this.onTap,
    this.isGreen = false,
  });

  /* final int index;
  final List<FoodModel> foodList; */

  final void Function() onTap;
  final FoodModel item;

  final bool isGreen;

  Color get _itemColor =>
      isGreen ? SwitchColors.greenItemColor : SwitchColors.itemBackgoundColor;

  Color get _btnColor =>
      isGreen ? const Color(0xFF1b5e20) : const Color(0xFFef6c00);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: _itemColor,
      ),
      child: Clicker(
        onClick: onTap,
        innerPadding: 0.0,
        child: IntrinsicHeight(
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
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
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
                        SizedBox(
                          width: context.screenWidth * .45,
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.foodName,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontFamily: FontFamily.mainFont,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${item.foodPrice.toString()} \$",
                          style: typePriceTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFD841F),
                            ),
                            Text(
                              item.foodRate.toString(),
                              style: const TextStyle(
                                color: Color(0xFFFD841F),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: context.screenWidth * .03,
                        ),
                        Text(
                          "(${item.numberOfReviewers} reviewer)",
                          style: const TextStyle(
                            fontFamily: FontFamily.subFont,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OrderButtonWidget(
                          item: item,
                          buttonColor: _btnColor,
                        ),
                        /*   SizedBox(
                          width: context.screenWidth * .03,
                        ), */
                        const Gap(wRatio: 0.03),
                        /* const Icon(
                          Icons.add_circle,
                          color: Color(0xFF1F8A70),
                          size: 35,
                        ), */
                        CartIconButton(target: item),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
