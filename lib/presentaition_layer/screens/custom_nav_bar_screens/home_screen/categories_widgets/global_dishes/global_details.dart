import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/global_dishes_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_body.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/components/show_full_profile_image.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/ratting_sector.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/order_or_add_to_cart.dart';
import 'package:foodapp/presentaition_layer/widgets/pop_button_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class GlobalDishesDetails extends StatelessWidget {
  const GlobalDishesDetails({
    super.key,
    required this.item,
  });

  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    final List<FoodModel> wishList =
        context.watch<WishListProvider>().favoriteItems;
    final bool isExist = wishList.any((test) => test.id == item.id);

    final bool isLoading = context.watch<WishListProvider>().isLoading;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: <Widget>[
            // BODY
            GlobalBody(item: item),
            Clicker(
              innerPadding: 0.0,
              onClick: () async {
                await showFullImage(item.imagePath);
              },
              child: Container(
                height: context.screenHeight * .3,
                decoration: BoxDecoration(
                  borderRadius: borderRaduis(20.0, side: Side.bottom),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(item.imagePath),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Gap(hRatio: 0.05),
                    Padding(
                      padding: padding(10, from: From.horizontal),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const PopBtn(),
                          Container(
                            padding: padding(10),
                            decoration: BoxDecoration(
                              borderRadius: borderRaduis(15),
                              border: Border.all(color: Colors.white),
                              color: Colors.black26,
                            ),
                            child: Text(
                              item.foodName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: FontFamily.mainFont,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: context.screenHeight * .3 - 25,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: context.screenWidth * .5,
                    padding: padding(10),
                    decoration: BoxDecoration(
                      borderRadius: borderRaduis(20),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              item.foodRate.toString(),
                              style: const TextStyle(
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        Text("(${item.numberOfReviewers.toString()} reviewer)")
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFef6c00),
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await context
                            .read<WishListProvider>()
                            .addItemToFirestoreWishList(item);
                      },
                      icon: isLoading
                          ? LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.orange,
                              size: 25.0,
                            )
                          : isExist
                              ? const Icon(
                                  Icons.favorite,
                                  color: Color(0xFFef6c00),
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Color(0xFFef6c00),
                                  size: 30,
                                ),
                    ),
                  ),
                ],
              ),
            ),
            OrderOrAddtoCartWidget(item: item)
          ],
        ),
      ),
    );
  }
}
