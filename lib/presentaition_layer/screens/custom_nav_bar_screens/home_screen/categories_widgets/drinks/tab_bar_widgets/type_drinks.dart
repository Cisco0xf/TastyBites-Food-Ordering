import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/add_icon_btn.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:provider/provider.dart';

class TypeDrinksWidget extends StatelessWidget {
  const TypeDrinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchingProvider>(
      builder: (context, searching, child) {
        return searching.searchingWithoutData
            ? const NotFounCategoryWidget(category: "drinks")
            : Directionality(
                textDirection: TextDirection.ltr,
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: context.screenHeight * .1),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: context.screenHeight * .42,
                  ),
                  itemCount: searching.filtred.length,
                  itemBuilder: (context, index) {
                    final FoodModel item = searching.filtred[index];
                    return GridFoodItem(
                      item: item,
                      onTap: () => pushTo(FoodDetials(item: item)),
                    ) /* GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return searching.isUserNotSearch
                                  ? FoodDetials(
                                      item: typeDrinks[index])
                                  : FoodDetials(
                                      item: searching.filteredDrinks[index]);
                            },
                          ),
                        );
                      },
                      child: GridFoodItem(
                        index: index,
                        drinkList: searching.isUserNotSearch
                            ? typeDrinks
                            : searching.filteredDrinks,
                      ),
                    ) */
                        ;
                  },
                ),
              );
      },
    );
  }
}

class GridFoodItem extends StatelessWidget {
  const GridFoodItem({
    super.key,
    /*   required this.drinkList,
    required this.index, */
    required this.item,
    required this.onTap,
  });
  /* 
  final int index;
  final List<FoodModel> drinkList; */

  final FoodModel item;
  final void Function() onTap;

  String get _price => item.foodPrice.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return Container(
      /* height: context.screenHeight * .43, */
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: SwitchColors.itemBackgoundColor,
      ),
      margin: padding(7.0),
      child: Clicker(
        onClick: onTap,
        innerPadding: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicWidth(
                child: SizedBox(
                  height: context.screenHeight * .2,
                  child: ClipRRect(
                    borderRadius: borderRaduis(20),
                    child: Hero(
                      tag: item.foodName,
                      child: Image.asset(item.imagePath, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: borderRaduis(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: padding(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.foodName,
                              overflow: TextOverflow.ellipsis,
                              style: typeNameTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: context.screenHeight * .04,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "$_price \$",
                                style: typePriceTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFF9F54B),
                              ),
                              Text(
                                item.foodRate.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Color(0xFFF9F54B),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "   (${item.numberOfReviewers.toString()}) reviewer",
                            style: const TextStyle(
                              fontFamily: FontFamily.subFont,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OrderButtonWidget(item: item),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
