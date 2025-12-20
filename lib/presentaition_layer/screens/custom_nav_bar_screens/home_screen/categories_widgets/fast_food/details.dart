import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/ratting_sector.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/components/show_full_profile_image.dart';
import 'package:foodapp/presentaition_layer/widgets/favorite_button.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/order_or_add_to_cart.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/quantity_widget.dart';
import 'package:foodapp/presentaition_layer/widgets/pop_button_widget.dart';
import 'package:provider/provider.dart';

class FoodDetials extends StatelessWidget {
  const FoodDetials({
    super.key,
    required this.item,
  });

  final FoodModel item;

  double get numberOfReviewersGreaterThousand {
    if (item.numberOfReviewers > 1000) {
      return item.numberOfReviewers / 1000;
    }
    return item.numberOfReviewers.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    /*  final List<FoodModel> wishListItem =
        context.watch<WishListProvider>().favoriteItems; */

    // final bool isExist = wishListItem.any((food) => item.id == food.id);
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: <Widget>[
            Container(
              height: context.screenHeight * .4,
              width: double.infinity - 30,
              padding: EdgeInsets.only(top: context.screenHeight * .06),
              child: Stack(
                children: <Widget>[
                  Clicker(
                    onClick: () async {
                      await showFullImage(item.imagePath);
                    },
                    child: Center(
                      child: Hero(
                        tag: item.foodName,
                        child: Image.asset(item.imagePath),
                      ),
                    ),
                  ),
                  Padding(
                    padding: padding(7.0, from: From.horizontal),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const PopBtn(),
                        Text(
                          item.foodName,
                          style: const TextStyle(
                            fontFamily: FontFamily.mainFont,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FavoriteButtonWidget(item: item),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: borderRaduis(20.0, side: Side.top),
                  color: SwitchColor.bgColor,
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  item.foodName,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.subFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "${item.foodPrice.toStringAsFixed(2)} \$",
                                  style: const TextStyle(
                                    fontFamily: FontFamily.subFont,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0FA958),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: padding(20.0, from: From.horizontal),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text.rich(
                                  TextSpan(
                                    text: "Calories : ",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: "${item.calories} calory",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFb71c1c),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(hRatio: 0.01),
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
                                    item.foodRate.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Color(0xFFEE5007),
                                      fontFamily: FontFamily.mainFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    item.numberOfReviewers > 1000
                                        ? "   (${numberOfReviewersGreaterThousand.toStringAsFixed(1)} K reviewer)"
                                        : "   (${numberOfReviewersGreaterThousand.toInt()} reviewer)",
                                    style: const TextStyle(
                                      fontFamily: FontFamily.subFont,
                                      fontSize: 17,
                                    ),
                                  )
                                ],
                              ),
                              RatingBar.builder(
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
                              ),
                            ],
                          ),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 10,
                            ),
                            child: Text(
                              item.description,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                fontSize: 17,
                                fontFamily: FontFamily.subFont,
                              ),
                            ),
                          ),
                          QuantityWidget(item: item),
                          const Gap(hRatio: 0.1),
                        ],
                      ),
                    ),
                    OrderOrAddtoCartWidget(item: item),
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
