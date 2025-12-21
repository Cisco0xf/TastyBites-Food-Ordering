import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_body.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/order_or_add_to_cart.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/quantity_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/components/show_full_profile_image.dart';
import 'package:foodapp/presentaition_layer/widgets/favorite_button.dart';
import 'package:foodapp/presentaition_layer/widgets/pop_button_widget.dart';

class ShowDishesDetailsWidget extends StatelessWidget {
  const ShowDishesDetailsWidget({super.key, required this.item});

  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              top: context.screenHeight * .3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRaduis(20.0, side: Side.top),
                  color: SwitchColor.bgColor,
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const Gap(hRatio: 0.1),
                          /* Padding(
                            padding: padding(20.0, from: From.horizontal),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  item.foodName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.subFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "${item.foodPrice} \$",
                                  style: const TextStyle(
                                    fontFamily: FontFamily.subFont,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0FA958),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ), */
                          ItemTitle(item: item),
                          const Gap(hRatio: .01),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rate,
                                    color: Color(0xFFEE5007),
                                  ),
                                  Text(
                                    "${item.foodRate}",
                                    style: const TextStyle(
                                      color: Color(0xFFEE5007),
                                      fontFamily: FontFamily.mainFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.screenWidth * .01,
                                  ),
                                  Text(
                                    "   (${item.numberOfReviewers} reviewer)",
                                    style: const TextStyle(
                                      fontFamily: FontFamily.subFont,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                              /*  RatingBar.builder(
                                maxRating: 5.0,
                                minRating: 0.0,
                                itemCount: 5,
                                itemSize: 30,
                                direction: Axis.horizontal,
                                initialRating: item.foodRate,
                                allowHalfRating: true,
                                itemBuilder: (context, index) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  );
                                },
                                onRatingUpdate: (double rating) {},
                              ), */
                              ItemRating(rate: item.foodRate),
                            ],
                          ),
                          const Divider(),
                          ItemDescription(description: item.description),
                          IngerdeintsItems(item: item, isGreen: true),
                          // IngredientsList(item: item),
                          QuantityWidget(item: item),
                          const Gap(hRatio: .1),
                        ],
                      ),
                    ),
                    OrderOrAddtoCartWidget(
                      orderButtonColor: const Color(0xFF1b5e20),
                      item: item,
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              bottom: null,
              child: Container(
                height: context.screenHeight * .4,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: borderRaduis(20.0, side: Side.bottom)),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: item.foodName,
                        child: Clicker(
                          innerPadding: 0.0,
                          onClick: () async {
                            await showFullImage(item.imagePath);
                          },
                          child: ClipRRect(
                            borderRadius: borderRaduis(20.0, side: Side.bottom),
                            child: Image.asset(
                              item.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: context.screenHeight * .05,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: padding(7.0, from: From.horizontal),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const PopBtn(),
                            FavoriteButtonWidget(item: item),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/* 
class IngredientsList extends StatelessWidget {
  const IngredientsList({super.key, required this.item});

  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          for (int i = 0; i < item.ingredientsNames!.length; i++)
            Container(
              padding: padding(5),
              margin: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 5,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFc6ff00)
          
                ),
                color: Colors.white30,
                borderRadius: borderRaduis(15),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: context.screenWidth * .2,
                    height: context.screenHeight * .1,
                    child: Image.asset(item.ingredientsImages![i]),
                  ),
                  Text(
                    item.ingredientsNames![i],
                    style: const TextStyle(
                      fontFamily: FontFamily.subFont,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
 */