/* import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/order_or_add_to_cart.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/quantity_widget.dart';
import 'package:foodapp/presentaition_layer/widgets/favorite_button.dart';
import 'package:foodapp/presentaition_layer/widgets/pop_button_widget.dart';

class SushiDetailsWidget extends StatelessWidget {
  const SushiDetailsWidget({
    super.key,
  /*   required this.sushiName,
    required this.description,
    required this.imagePath,
    required this.sushiPrice,
    required this.sushiRate,
    required this.numberOfReviewers,
    required this.heroTag,
    required this.stock, */
    required this.item,
  });
  /* final String imagePath;
  final String sushiName;
  final String description;
  final double sushiPrice;
  final int numberOfReviewers;
  final double sushiRate;
  final int stock;
  final int heroTag; */
  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: context.screenHeight * .3,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: context.screenHeight * .1,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: SwitchColors.backgroundMianColor,
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  item.foodName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.mainFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
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
                          ),
                          SizedBox(
                            height: context.screenHeight * .01,
                          ),
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
                                  Text(
                                    "(${item.numberOfReviewers} reviewer)",
                                    style: const TextStyle(
                                      fontFamily: FontFamily.subFont,
                                      fontSize: 15,
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
                          SizedBox(
                            height: context.screenHeight * .1,
                          )
                        ],
                      ),
                    ),
                    OrderOrAddtoCartWidget(
                      item: item,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: context.screenHeight * .4,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.only(top: context.screenHeight * .0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Hero(
                        tag: item.foodName,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          child: Image.asset(
                            item.imagePath,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: context.screenHeight * .05,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const PopBtn(),
                            SizedBox(
                              width: context.screenWidth * .6,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  item.foodName,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.mainFont,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            FavoriteButtonWidget(
                              item: item,
                            ),
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
 */