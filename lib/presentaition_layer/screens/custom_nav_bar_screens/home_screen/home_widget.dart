import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories_items.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/searching_system/searchin_drink_provider.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/filtter_searching/searching_filter.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SearchingSystemProvider>(
        builder: (context, search, child) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: SwitchColors.backgroundMianColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: context.screenHeight * .06,
                          child: Consumer<CurrentIndexProvider>(
                            builder: (context, currentIndex, child) {
                              return Consumer<SearchingDrinksProvider>(
                                builder: (context, searchingDrinks, child) {
                                  return TextField(
                                    controller: currentIndex.currentIndex == 1
                                        ? searchingDrinks
                                            .searchingDrinkController
                                        : search.searchingProductsController,
                                    onChanged: (String searchedItem) {
                                      log("Text from onChange : $searchedItem");
                                      log("TExt from provider : ${search.searchingProductsController.text}");
                                      log("*" * 30);
                                      log("Length of filtered List : ${search.filteredList.length}");
                                      currentIndex.currentIndex == 1
                                          ? searchingDrinks.filterDrinke(
                                              context: context)
                                          : search.searchInCategory(
                                              context: context);
                                    },
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(20),
                                    ],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: borderRaduis(22),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: borderRaduis(22),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      fillColor:
                                          SwitchColors.searchFieldFillColor,
                                      filled: true,
                                      hintText:
                                          "${"search".localeValue(context: context)} \"${categoriesItems[currentIndex.currentIndex].itemTitle.localeValue(
                                                context: context,
                                              )}\" ${context.isArabicEg ? "؟" : ""}",
                                      hintStyle: context.isEnglish
                                          ? const TextStyle(
                                              fontSize: 15,
                                            )
                                          : const TextStyle(
                                              fontFamily: FontFamily.mainArabic,
                                              fontSize: 15,
                                            ),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Color(0xFF868686),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SearchingFilterWidget(),
                    ],
                  ),
                ),
                /* Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "categories".localeValue(context: context),
                        style: TextStyle(
                          fontFamily:
                              context.isEnglish ? null : FontFamily.mainArabic,
                          fontWeight: FontWeight.bold,
                          fontSize: context.isEnglish ? 18 : 20,
                        ),
                      ),
                    ],
                  ),
                ), */
                SizedBox(
                  height: context.screenHeight * .01,
                ),
                const CategoriesSectorWidget(),
                Consumer<CurrentIndexProvider>(
                  builder: (context, currentIndex, child) {
                    return categoriesItems[currentIndex.currentIndex]
                        .targetWidget;
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
