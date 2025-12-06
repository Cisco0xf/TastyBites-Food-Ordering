import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/sushi_demo_data.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/style.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/sushi/sushi_details_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:provider/provider.dart';

class SushiWidget extends StatelessWidget {
  const SushiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchingSystemProvider>(
      builder: (context, searching, child) {
        return searching.isItemNotExist
            ? const NotFounCategoryWidget(
                category: "sushi",
              )
            : Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: context.screenHeight * .1),
                  itemCount: searching.isSearchingBarEmpty
                      ? sushiDemoData.length
                      : searching.filteredList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return searching.isSearchingBarEmpty
                                  ? FastFoodDetailsScreen(
                                      /*  sushiName: sushiDemoData[index].foodName,
                                      sushiPrice:
                                          sushiDemoData[index].foodPrice,
                                      sushiRate: sushiDemoData[index].foodRate,
                                      description:
                                          sushiDemoData[index].description,
                                      imagePath: sushiDemoData[index].imagePath,
                                      numberOfReviewers: sushiDemoData[index]
                                          .numberOfReviewers,
                                      heroTag: index,
                                      stock: sushiDemoData[index].stock, */
                                      item: sushiDemoData[index],
                                    )
                                  : FastFoodDetailsScreen(
                                      /*  sushiName: searching
                                          .filteredList[index].foodName,
                                      sushiPrice: searching
                                          .filteredList[index].foodPrice,
                                      sushiRate: searching
                                          .filteredList[index].foodRate,
                                      description: searching
                                          .filteredList[index].description,
                                      imagePath: searching
                                          .filteredList[index].imagePath,
                                      numberOfReviewers: searching
                                          .filteredList[index]
                                          .numberOfReviewers,
                                      heroTag: index,
                                      stock:
                                          searching.filteredList[index].stock, */
                                      item: searching.filteredList[index],
                                    );
                            },
                          ),
                        );
                      },
                      child: SushiItemWidget(
                        index: index,
                        foodList: searching.isSearchingBarEmpty
                            ? sushiDemoData
                            : searching.filteredList,
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}

class SushiItemWidget extends StatelessWidget {
  const SushiItemWidget({
    super.key,
    required this.index,
    required this.foodList,
  });

  final int index;
  final List<FoodModel> foodList;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale("en"),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      child: Container(
        height: context.screenHeight * .3,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: borderRaduis(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              foodList[index].imagePath,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: borderRaduis(10),
                  ),
                  child: Text(
                    "${foodList[index].foodPrice} \$",
                    style: typePriceTextStyle,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      foodList[index].foodName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          foodList[index].foodRate.toString(),
                          style: const TextStyle(
                            color: Colors.yellow,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  foodList[index].description,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: FontFamily.subFont,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
