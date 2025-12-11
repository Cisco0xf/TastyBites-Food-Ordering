import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/fast_food/details.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/style.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:provider/provider.dart';

class SushiWidget extends StatelessWidget {
  const SushiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchingProvider>(
      builder: (context, searching, child) {
        return searching.searchingWithoutData
            ? const NotFounCategoryWidget(category: "sushi")
            : Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: context.screenHeight * .1),
                  itemCount: searching.filtred.length,
                  itemBuilder: (context, index) {
                    return SushiItemWidget(
                      target: searching.filtred[index],
                      onTap: () {
                        final FoodModel target = searching.filtred[index];

                        pushTo(FoodDetials(item: target));
                      },
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
    required this.target,
    required this.onTap,
  });

  final FoodModel target;

  final void Function() onTap;

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
        margin: padding(10),
        decoration: BoxDecoration(
          borderRadius: borderRaduis(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(target.imagePath),
          ),
        ),
        child: Clicker(
          onClick: onTap,
          innerPadding: 10.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: padding(7),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: borderRaduis(10),
                    ),
                    child: Text(
                      "${target.foodPrice} \$",
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
                        target.foodName,
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
                            target.foodRate.toString(),
                            style: const TextStyle(
                              color: Colors.yellow,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    target.description,
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
      ),
    );
  }
}
