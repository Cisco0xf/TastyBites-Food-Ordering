import 'package:flutter/material.dart';
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
    required this.item,
  });

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
                                ),
                              ),
                              Positioned(
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
          )),
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
