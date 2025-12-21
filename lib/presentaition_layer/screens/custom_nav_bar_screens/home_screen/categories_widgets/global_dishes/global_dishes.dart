// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/my_logger.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/global_dishes_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/food_slider.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/global_dishes/global_details.dart';
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
    getTheTimer();
    _controller = PageController(
      viewportFraction: 1.0,
      initialPage: currentIndex,
    );
  }

  Timer getTheTimer() {
    return Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        final bool isLast = currentIndex == pageViewGlobalDishes.length - 1;

        if (isLast) {
          currentIndex = 0;
        } else {
          currentIndex += 1;
        }

        try {
          if (_controller.hasClients && _controller.positions.isNotEmpty) {
            _controller.animateToPage(
              currentIndex,
              duration: const Duration(seconds: 2),
              curve: Curves.linear,
            );
          }
        } catch (error) {
          Log.log("Erro while auto-scroll => $error");
        }
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
        child: Consumer<SearchingProvider>(
          builder: (context, searching, _) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: FoodSlider(controller: _controller),
                ),
                if (searching.searchingWithoutData) ...{
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        const NotFounCategoryWidget(
                        ),
                        const Gap(hRatio: .13),
                      ],
                    ),
                  ),
                } else ...{
                  SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: context.screenHeight * .14,
                    ),
                    sliver: SliverList.builder(
                      itemCount: searching.filtred.length,
                      itemBuilder: (context, index) {
                        final FoodModel item = searching.filtred[index];
                        return GlobalDishItem(
                          item: item,
                          onTap: () {
                            pushTo(GlobalDishesDetails(item: item));
                          },
                        );
                      },
                    ),
                  ),
                },

                /*  searching.isItemNotExist
                    ? SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const NotFounCategoryWidget(
                              category: "global_dishes",
                            ),
                            const Gap(hRatio: .13), 
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
                                          ? GlobalDishesDetails(
                                              item: globalDishesDemoData[index],
                                            )
                                          : GlobalDishesDetails(
                                              item:
                                                  searching.filteredList[index],
                                            );
                                    },
                                  ),
                                );
                              },
                              child: GlobalDishItem(
                                index: index,
                                foodList: searching.isSearchingBarEmpty
                                    ? globalDishesDemoData
                                    : searching.filteredList,
                              ),
                            );
                          },
                        ),
                      ), */
              ],
            );
          },
        ),
      ),
    );
  }
}

class GlobalDishItem extends StatelessWidget {
  const GlobalDishItem({
    super.key,
    /* required this.index,
    required this.foodList, */
    required this.item,
    required this.onTap,
  });

  /*  final int index;
  final List<FoodModel> foodList; */

  final FoodModel item;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale("en"),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      child: Container(
        height: context.screenHeight * .28,
        margin: padding(10.0),
        //padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: borderRaduis(15),
          color: const Color(0xFFFFCF81),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(item.imagePath),
          ),
        ),
        child: Clicker(
          onClick: onTap,
          innerPadding: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: padding(10),
                    margin: padding(10),
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: borderRaduis(15),
                    ),
                    child: Text(
                      "${item.foodPrice.toString()} \$",
                      style: typePriceTextStyle,
                    ),
                  ),
                ],
              ),
              Container(
                height: context.screenHeight * .11,
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: borderRaduis(15.0, side: Side.bottom),
                  color: Colors.black26,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.foodName,
                      style: const TextStyle(
                        fontFamily: FontFamily.subFont,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      item.description,
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
            ],
          ),
        ),
      ),
    );
  }
}
