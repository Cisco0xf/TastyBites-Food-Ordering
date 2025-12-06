import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/order_or_add_to_cart.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/quantity_widget.dart';
import 'package:foodapp/presentaition_layer/widgets/favorite_button.dart';
import 'package:foodapp/presentaition_layer/widgets/pop_button_widget.dart';

class DessertsDetailsWidget extends StatelessWidget {
  const DessertsDetailsWidget({
    super.key,
    /* required this.imagePath,
    required this.dessertName,
    required this.description,
    required this.rate,
    required this.price,
    required this.numberOfReviewers,
    required this.item, */
    required this.item,
  });
  /*  final String imagePath;
  final String dessertName;
  final String description;
  final double rate;
  final double price;
  final int numberOfReviewers;
  final dynamic item; */

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
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(top: context.screenHeight * .1),
                decoration:
                    BoxDecoration(color: SwitchColors.backgroundMianColor),
                child: SingleChildScrollView(
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
                              style: const TextStyle(
                                fontFamily: FontFamily.mainFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
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
                      QuantityWidget(
                        item: item,
                      ),
                      SizedBox(
                        height: context.screenHeight * .1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: context.screenHeight * .05,
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    height: context.screenHeight * .4,
                    decoration: BoxDecoration(
                      color: SwitchColors.dessertsBGCOlor,
                      borderRadius: borderRaduis(30),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: context.screenHeight * .03,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: context.screenWidth * .8,
                              height: context.screenHeight * .24,
                              decoration: BoxDecoration(
                                borderRadius: borderRaduis(10),
                                color: Colors.amber,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(item.imagePath),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const PopButtonWidget(
                                buttonColor: Colors.white,
                              ),
                              Text(
                                item.foodName,
                                style: const TextStyle(
                                  fontFamily: FontFamily.mainFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              FavoriteButtonWidget(
                                item: item,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  OrderOrAddtoCartWidget(
                    item: item,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDessertDetailsClipper extends CustomClipper<Path> {
  @override
  // CustomClipper takes the width and height of the widget which wrapped with it.
  Path getClip(Size size) {
    // An instance of Path Object
    final Path path = Path();

    /// Start with width 0(the start of the width), and the height.
    /// If I want to change the position of the width or height of the clipper I will change path.lineTo(0, size.height);
    path.lineTo(0, size.height - 50);
    // Values of the first Curve
    /// These Points are the pooints which clipper will change from the middel
    /// Also this points makes the curves of the clipper
    Offset firstStartPointClip = Offset(size.width * .2, size.height);
    Offset firsEndPointClip = Offset(size.width, size.height);
    // Executing the curvers of the first points of the clipper according to the given values(the firstCurve)
    path.quadraticBezierTo(
      firstStartPointClip.dx,
      firstStartPointClip.dy,
      firsEndPointClip.dx,
      firsEndPointClip.dy,
    );
    // Values of the second Curve
    Offset secondStartPointClip = Offset(size.width, size.height);
    Offset secondEndPointClip = Offset(size.width, size.height * -.2);
    // Executing the curvers of the second points of the clipper according to the given values(the secondCurve)
    path.quadraticBezierTo(
      secondStartPointClip.dx,
      secondStartPointClip.dy,
      secondEndPointClip.dx,
      secondEndPointClip.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
