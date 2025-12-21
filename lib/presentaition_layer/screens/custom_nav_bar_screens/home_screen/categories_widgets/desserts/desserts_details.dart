import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/order_or_add_to_cart.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/quantity_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/components/show_full_profile_image.dart';
import 'package:foodapp/presentaition_layer/widgets/favorite_button.dart';
import 'package:foodapp/presentaition_layer/widgets/pop_button_widget.dart';

class FoodDetails extends StatelessWidget {
  const FoodDetails({
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
      backgroundColor: SwitchColor.bgColor,
      body: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _DetailsDelegate(
                        child: Container(
                          decoration: BoxDecoration(
                            color: SwitchColor.accent.withOpacity(0.2),
                            borderRadius: borderRaduis(30, side: Side.bottom),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 15.0,
                                left: 20.0,
                                right: 20.0,
                                child: SizedBox(
                                  height: context.screenHeight * .25,
                                  child: Clicker(
                                    onClick: () async => await showFullImage(
                                      item.imagePath,
                                    ),
                                    child: Hero(
                                      tag: item.foodName,
                                      child: ClipRRect(
                                        borderRadius: borderRaduis(10),
                                        child: Image.asset(
                                          item.imagePath,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  /* decoration: BoxDecoration(
                                    borderRadius: borderRaduis(10),
                                    color: Colors.amber,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ,
                                    ),
                                  ), */
                                ),
                              ),
                              Positioned(
                                /*  padding:
                                    padding(10.0, from: From.horizontal), */
                                right: 10.0,
                                left: 10.0,
                                top: context.screenHeight * .05,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const PopBtn(),
                                    FavoriteButtonWidget(item: item),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          const Gap(height: 10.0),
                          ItemTitle(item: item),
                          const Gap(hRatio: 0.01),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                children: [
                                  const Icon(Icons.star_rate,
                                      color: Color(0xFFEE5007)),
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
                              // Rate Here
                              ItemRating(rate: item.foodRate),
                            ],
                          ),
                          const Divider(),
                          ItemDescription(description: item.description),
                          QuantityWidget(item: item),
                          /* SizedBox(
                              height: context.screenHeight * .1,
                            ), */
                          const Gap(hRatio: 0.1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              OrderOrAddtoCartWidget(item: item),
            ],
          )

          /*  Stack(
          children: <Widget>[
            Positioned(
              top: context.screenHeight * .3,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(top: context.screenHeight * .1),
                decoration: BoxDecoration(color: SwitchColor.bgColor),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                  
                      const Gap(height: 10.0),
                      Padding(
                        padding: padding(20.0, from: From.horizontal),
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
                   
                      const Gap(hRatio: 0.01),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rate,
                                color: Color(0xFFEE5007)
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
                          // Rate Here
                          ItemRating(rate: item.foodRate),
                        ],
                      ),
                      const Divider(),
                      const Row(
                        children: <Widget>[
                          Gap(width: 10.0),
                          Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: padding(10.0),
                        /*  const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ), */
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
                      /* SizedBox(
                        height: context.screenHeight * .1,
                      ), */
                      const Gap(hRatio: 0.1),
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
                      color: SwitchColor.primaryO,
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
                          padding: padding(10.0, from: From.horizontal),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const PopBtn(),
                              Text(
                                item.foodName,
                                style: const TextStyle(
                                  fontFamily: FontFamily.mainFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              FavoriteButtonWidget(item: item),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  OrderOrAddtoCartWidget(item: item),
                ],
              ),
            ),
          ],
        ), */
          ),
    );
  }
}

class _DetailsDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  final Widget child;

  _DetailsDelegate({required this.child});

  final BuildContext context = navigationKey.currentContext as BuildContext;

  @override
  double get maxExtent => context.screenHeight * .4;

  @override
  double get minExtent => context.screenHeight * .3;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    final bool shouldRebuild = oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;

    return shouldRebuild;
  }
}
/* 
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
} */
