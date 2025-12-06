// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/global_dishes_model.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_details_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/x_not_found/not_found_category.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GlobalDishesWidget extends StatefulWidget {
  const GlobalDishesWidget({super.key});

  @override
  State<GlobalDishesWidget> createState() => _GlobalDishesWidgetState();
}

class _GlobalDishesWidgetState extends State<GlobalDishesWidget> {
  late PageController _controller;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getTheTimer;
    _controller = PageController(
      viewportFraction: 1.0,
      initialPage: currentIndex,
    );
  }

  Timer get getTheTimer {
    return Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        if (currentIndex == pageViewGlobalDishes.length - 1) {
          currentIndex = 0;
        } else {
          currentIndex += 1;
        }
        try {
          _controller.animateToPage(
            currentIndex,
            duration: const Duration(seconds: 2),
            curve: Curves.linear,
          );
        } catch (_) {}
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Expanded(
        child: Consumer<SearchingSystemProvider>(
          builder: (context, searching, child) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Column(
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
                              controller: _controller,
                              allowImplicitScrolling: true,
                              itemCount: pageViewGlobalDishes.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return GlobalDishesDetailsWidget(
                                            /*  dishName:
                                                pageViewGlobalDishes[index]
                                                    .foodName,
                                            description:
                                                pageViewGlobalDishes[index]
                                                    .description,
                                            imagePath:
                                                pageViewGlobalDishes[index]
                                                    .imagePath,
                                            price: pageViewGlobalDishes[index]
                                                .foodPrice,
                                            rate: pageViewGlobalDishes[index]
                                                .foodRate,
                                            numberOfReviewers:
                                                pageViewGlobalDishes[index]
                                                    .numberOfReviewers,
                                            countryFlag:
                                                pageViewGlobalDishes[index]
                                                    .dishCountryFlag,
                                            country: pageViewGlobalDishes[index]
                                                .dishCountry,
                                            targetIndex: index, */
                                            item: pageViewGlobalDishes[index],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Localizations(
                                    locale: const Locale("en"),
                                    delegates: const <LocalizationsDelegate<
                                        dynamic>>[
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
                                            pageViewGlobalDishes[index]
                                                .imagePath,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      borderRaduis(20),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                pageViewGlobalDishes[index]
                                                    .foodName,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      FontFamily.mainFont,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                ),
                                              ),
                                              Text(
                                                pageViewGlobalDishes[index]
                                                    .description,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      FontFamily.subFont,
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
                            controller: _controller,
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
                      ),
                    ],
                  ),
                ),
                searching.isItemNotExist
                    ? SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const NotFounCategoryWidget(
                              category: "global_dishes",
                            ),
                            SizedBox(
                              height: context.screenHeight * .13,
                            )
                          ],
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: searching.isSearchingBarEmpty
                              ? globalDishesDemoData.length
                              : searching.filteredList.length,
                          (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return searching.isSearchingBarEmpty
                                          ? GlobalDishesDetailsWidget(
                                              /*  dishName:
                                                  globalDishesDemoData[index]
                                                      .foodName,
                                              description:
                                                  globalDishesDemoData[index]
                                                      .description,
                                              imagePath:
                                                  globalDishesDemoData[index]
                                                      .imagePath,
                                              price: globalDishesDemoData[index]
                                                  .foodPrice,
                                              rate: globalDishesDemoData[index]
                                                  .foodRate,
                                              numberOfReviewers:
                                                  globalDishesDemoData[index]
                                                      .numberOfReviewers,
                                              countryFlag:
                                                  globalDishesDemoData[index]
                                                      .dishCountryFlag,
                                              country:
                                                  globalDishesDemoData[index]
                                                      .dishCountry,
                                              targetIndex: index, */
                                              item: globalDishesDemoData[index],
                                            )
                                          : GlobalDishesDetailsWidget(
                                              /*  dishName: searching
                                                  .filteredList[index].foodName,
                                              description: searching
                                                  .filteredList[index]
                                                  .description,
                                              imagePath: searching
                                                  .filteredList[index]
                                                  .imagePath,
                                              price: searching
                                                  .filteredList[index]
                                                  .foodPrice,
                                              rate: searching
                                                  .filteredList[index].foodRate,
                                              numberOfReviewers: searching
                                                  .filteredList[index]
                                                  .numberOfReviewers,
                                              countryFlag: searching
                                                  .filteredList[index]
                                                  .dishCountryFlag,
                                              country: searching
                                                  .filteredList[index]
                                                  .dishCountry,
                                              targetIndex: index, */
                                              item:
                                                  searching.filteredList[index],
                                            );
                                    },
                                  ),
                                );
                              },
                              child: GlobalDishItemWidget(
                                index: index,
                                foodList: searching.isSearchingBarEmpty
                                    ? globalDishesDemoData
                                    : searching.filteredList,
                              ),
                            );
                          },
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class GlobalDishItemWidget extends StatelessWidget {
  const GlobalDishItemWidget({
    super.key,
    required this.index,
    required this.foodList,
  });

  final int index;
  final List<FoodModel> foodList;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale("en"),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      child: Container(
        height: context.screenHeight * .3,
        margin: index == foodList.length - 1
            ? EdgeInsets.only(
                bottom: context.screenHeight * .1,
                left: 10,
                right: 10,
                top: 10,
              )
            : const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: borderRaduis(15),
          color: const Color(0xFFFFCF81),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(foodList[index].imagePath),
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
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: borderRaduis(15),
                  ),
                  child: Text(
                    "${foodList[index].foodPrice.toString()} \$",
                    style: typePriceTextStyle,
                  ),
                ),
              ],
            ),
            IntrinsicWidth(
              child: Container(
                height: context.screenHeight * .11,
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                  color: Colors.black26,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          foodList[index].foodName,
                          style: const TextStyle(
                            fontFamily: FontFamily.subFont,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      foodList[index].description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.subFont,
                        color: Colors.white,
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
