import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/global_dishes_model.dart';
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
    /* required this.dishName,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.rate,
    required this.numberOfReviewers,
    required this.countryFlag,
    required this.country,
    required this.targetIndex, */
    required this.item,
  });
  /* final String dishName;
  final String description;
  final String imagePath;
  final double price;
  final double rate;
  final int numberOfReviewers;
  final String countryFlag;
  final String country;
  final int targetIndex; */
  final FoodModel item;

  bool get _hasFlage =>
      item.dishCountry != null && item.dishCountryFlag != null;

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
            Positioned.fill(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: context.screenHeight * .27,
                    ),
                    decoration: BoxDecoration(
                      color: SwitchColor.bgColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.foodName,
                                          style: const TextStyle(
                                            fontFamily: FontFamily.mainFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        if (_hasFlage)
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: borderRaduis(7),
                                                ),
                                                width:
                                                    context.screenWidth * .11,
                                                height:
                                                    context.screenHeight * .04,
                                                child: ClipRRect(
                                                  borderRadius: borderRaduis(7),
                                                  child: SvgPicture.asset(
                                                    fit: BoxFit.cover,
                                                    item.dishCountryFlag!,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                item.dishCountry ?? "",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily:
                                                      FontFamily.subFont,
                                                ),
                                              ),
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Text(
                                      "${item.foodPrice} \$",
                                      style: const TextStyle(
                                        fontFamily: FontFamily.subFont,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0FA958),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: context.screenHeight * .01,
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: context.screenWidth * .55,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
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
                                      ],
                                    ),
                                  ),
                                  const ReviewersSector(),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "INGREDIENTS",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            if (item.ingredientsImages != null)
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: context.screenHeight * .09,
                                ),
                                width: context.screenWidth,
                                height: context.screenHeight * .3,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: item.ingredientsImages!
                                      .length /*  globalDishesDemoData[targetIndex]
                                    .ingredientsImages
                                    .length */
                                  ,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(7),
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFFF8551),
                                          width: 2,
                                        ),
                                        borderRadius: borderRaduis(15),
                                        color: context.isLight
                                            ? Colors.white
                                            : Colors.black38,
                                      ),
                                      child: item.ingredientsImages != null
                                          ? Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width:
                                                      context.screenWidth * .3,
                                                  height:
                                                      context.screenHeight * .1,
                                                  child: Image.asset(
                                                    item.ingredientsImages![
                                                        index],
                                                  ),
                                                ),
                                                Text(item
                                                    .ingredientsNames![index])
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                    );
                                  },
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: context.screenHeight * .3,
                    constraints:
                        BoxConstraints(maxHeight: context.screenHeight * .3),
                    padding: EdgeInsets.only(top: context.screenHeight * .07),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          item.imagePath,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const PopButtonWidget(
                                buttonColor: Colors.black,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: borderRaduis(15),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
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
                  Positioned(
                    top: context.screenHeight * .3 - 25,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: context.screenWidth * .5,
                          padding: const EdgeInsets.all(10),
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
                              Text(
                                  "(${item.numberOfReviewers.toString()} reviewer)")
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
                  OrderOrAddtoCartWidget(
                    item: item,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
