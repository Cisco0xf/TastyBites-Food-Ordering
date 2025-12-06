import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/order_or_add_to_cart.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/quantity_widget.dart';
import 'package:foodapp/presentaition_layer/widgets/pop_button_widget.dart';
import 'package:provider/provider.dart';

class FastFoodDetailsScreen extends StatefulWidget {
  const FastFoodDetailsScreen({
    super.key,
    /* required this.imagePath,
    required this.foodName,
    required this.foodPrice,
    required this.description,
    required this.rate,
    required this.calories,
    required this.numberOfReviewers,
    required this.item,
    required this.heroTage, */
    required this.item,
  });

  /*  final String imagePath;
  final String foodName;
  final String description;
  final int calories;
  final double foodPrice;
  final double rate;
  final int numberOfReviewers;
  final String heroTage;
  final FoodModel item; */

  final FoodModel item;

  @override
  State<FastFoodDetailsScreen> createState() => _FastFoodDetailsScreenState();
}

class _FastFoodDetailsScreenState extends State<FastFoodDetailsScreen> {
  late double reviewers;
  @override
  void initState() {
    reviewers = widget.item.numberOfReviewers.toDouble();

    super.initState();
  }

  double get numberOfReviewersGreaterThousand {
    if (reviewers > 1000) {
      reviewers = reviewers / 1000;
      return reviewers;
    } else {
      return reviewers;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Center(
                    child: Hero(
                      tag: widget.item.foodName,
                      child: Image.asset(widget.item.imagePath),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const PopButtonWidget(),
                        Text(
                          widget.item.foodName,
                          style: const TextStyle(
                            fontFamily: FontFamily.mainFont,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFFF6D28),
                              width: 1,
                            ),
                            color: Colors.white24,
                            borderRadius: borderRaduis(7),
                          ),
                          child: Consumer<WishListProvider>(
                            builder: (context, addToFavorite, child) {
                              return IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () async {
                                  await addToFavorite.addItemToFavorite(
                                    item: widget.item,
                                  );
                                },
                                icon: addToFavorite.favoriteItems
                                        .contains(widget.item)
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Color(0xFFFF6D28),
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        size: 30,
                                        color: Color(0xFFFF6D28),
                                      ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  widget.item.foodName,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.subFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "${widget.item.foodPrice.toStringAsFixed(2)} \$",
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                        text: "${widget.item.calories} calory",
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
                                    widget.item.foodRate.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Color(0xFFEE5007),
                                      fontFamily: FontFamily.mainFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    widget.item.numberOfReviewers > 1000
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
                                initialRating: widget.item.foodRate,
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
                              widget.item.description,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                fontSize: 17,
                                fontFamily: FontFamily.subFont,
                              ),
                            ),
                          ),
                          QuantityWidget(
                            item: widget.item,
                          ),
                          SizedBox(
                            height: context.screenHeight * .1,
                          )
                        ],
                      ),
                    ),
                    OrderOrAddtoCartWidget(
                      item: widget.item,
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
