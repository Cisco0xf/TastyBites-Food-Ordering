import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/desserts_demo_data.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/desserts/desserts_details.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:foodapp/presentaition_layer/widgets/order_button.dart';
import 'package:provider/provider.dart';

class DessertsWidget extends StatelessWidget {
  const DessertsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Consumer<SearchingSystemProvider>(
            builder: (context, searching, child) {
              return searching.isItemNotExist
                  ? const NotFounCategoryWidget(
                      category: "desserts",
                    )
                  : ListView.builder(
                      padding:
                          EdgeInsets.only(bottom: context.screenHeight * .1),
                      itemCount: searching.isSearchingBarEmpty
                          ? dessertDemoData.length
                          : searching.filteredList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return searching.isSearchingBarEmpty
                                        ? DessertsDetailsWidget(
                                            /*  imagePath: dessertDemoData[index]
                                                .imagePath,
                                            dessertName:
                                                dessertDemoData[index].foodName,
                                            numberOfReviewers:
                                                dessertDemoData[index]
                                                    .numberOfReviewers,
                                            description: dessertDemoData[index]
                                                .description,
                                            price: dessertDemoData[index]
                                                .foodPrice,
                                            rate:
                                                dessertDemoData[index].foodRate, */
                                            item: dessertDemoData[index],
                                          )
                                        : DessertsDetailsWidget(
                                            /* imagePath: searching
                                                .filteredList[index].imagePath,
                                            dessertName: searching
                                                .filteredList[index].foodName,
                                            numberOfReviewers: searching
                                                .filteredList[index]
                                                .numberOfReviewers,
                                            description: searching
                                                .filteredList[index]
                                                .description,
                                            price: searching
                                                .filteredList[index].foodPrice,
                                            rate: searching
                                                .filteredList[index].foodRate, */
                                            item: searching.filteredList[index],
                                          );
                                  },
                                ),
                              );
                            },
                            child: DessertsItemWidget(
                              index: index,
                              foodList: searching.isSearchingBarEmpty
                                  ? dessertDemoData
                                  : searching.filteredList,
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}

class DessertsItemWidget extends StatelessWidget {
  const DessertsItemWidget({
    super.key,
    required this.index,
    required this.foodList,
  });
  final int index;
  final List<FoodModel> foodList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          height: context.screenHeight * .3,
          decoration: BoxDecoration(
            borderRadius: borderRaduis(15),
            color: Colors.black26,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                foodList[index].imagePath,
              ),
            ),
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: borderRaduis(20),
              gradient: LinearGradient(
                colors: SwitchColors.dessertInfoBoxColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  foodList[index].foodName,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${foodList[index].foodPrice.toString()}  \$",
                  style: typePriceTextStyle,
                ),
                Row(
                  children: <Widget>[
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          foodList[index].foodRate.toString(),
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontFamily: FontFamily.mainFont,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "   (${foodList[index].numberOfReviewers} reviewer)",
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: FontFamily.subFont,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    OrderButtonWidget(
                      item: foodList[index],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle,
                        size: 35,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
