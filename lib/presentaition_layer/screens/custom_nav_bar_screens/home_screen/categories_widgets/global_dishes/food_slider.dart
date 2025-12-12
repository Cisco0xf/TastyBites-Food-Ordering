import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/data_layer/data_models/global_dishes_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_details_widget.dart';
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
                child: Localizations(
                  locale: const Locale("en"),
                  delegates: const <LocalizationsDelegate<dynamic>>[
                    DefaultMaterialLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate
                  ],
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.all(10),
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
                              padding: const EdgeInsets.all(10),
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
          effect: const JumpingDotEffect(
            activeDotColor: Color(0xFFFF785B),
          ),
        ),
        const Divider(
          endIndent: 40,
          indent: 40,
        ),
      ],
    );
  }
}
