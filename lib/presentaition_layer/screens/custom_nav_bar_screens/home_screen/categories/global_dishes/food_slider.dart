import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_models/global_dishes_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories/global_dishes/global_details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FoodSlider extends StatelessWidget {
  const FoodSlider({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Text(
                "Special dishes",
                style: TextStyle(
                  fontFamily: FontFamily.mainFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: context.screenHeight * .25,
          child: PageView.builder(
            controller: controller,
            allowImplicitScrolling: true,
            itemCount: pageViewGlobalDishes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => pushTo(
                  GlobalDishesDetails(item: pageViewGlobalDishes[index]),
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    margin: padding(10.0, from: From.horizontal),
                    padding: padding(10),
                    decoration: BoxDecoration(
                      borderRadius: borderRaduis(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          pageViewGlobalDishes[index].imagePath,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: padding(10),
                              decoration: BoxDecoration(
                                borderRadius: borderRaduis(20),
                                color: Colors.white38,
                              ),
                              child: Text(
                                "${pageViewGlobalDishes[index].foodPrice.toString()} \$",
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              pageViewGlobalDishes[index].foodName,
                              style: const TextStyle(
                                fontFamily: FontFamily.mainFont,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              pageViewGlobalDishes[index].description,
                              overflow: TextOverflow.ellipsis,
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
            },
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: pageViewGlobalDishes.length,
          effect: JumpingDotEffect(activeDotColor: SwitchColor.primaryO),
        ),
        const Divider(endIndent: 30.0, indent: 30.0),
      ],
    );
  }
}
