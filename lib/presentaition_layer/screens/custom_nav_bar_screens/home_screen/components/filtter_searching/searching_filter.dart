import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/searching_filter/price_filter_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/ratting_provider.dart';
import 'package:foodapp/statemanagement/searching_system/searchin_drink_provider.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/style.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/filtter_searching/ratting_model.dart';
import 'package:provider/provider.dart';

class SearchingFilterWidget extends StatefulWidget {
  const SearchingFilterWidget({super.key});

  @override
  State<SearchingFilterWidget> createState() => _SearchingFilterWidgetState();
}

class _SearchingFilterWidgetState extends State<SearchingFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: context.screenHeight * .06,
        width: context.screenWidth * .18,
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(
          left: context.isEnglish ? 10 : 0,
          right: context.isEnglish ? 0 : 10,
        ),
        decoration: BoxDecoration(
          color: SwitchColors.filterColor,
          borderRadius: borderRaduis(22),
        ),
        child: const FittedBox(
          fit: BoxFit.contain,
          child: Icon(
            Icons.tune_rounded,
          ),
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxHeight: context.screenHeight * .7,
          ),
          builder: (context) {
            return StatefulBuilder(
              builder: (
                BuildContext context,
                StateSetter setState,
              ) {
                return Consumer<SearchingFilterProvider>(
                  builder: (context, filterPrice, child) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: context.screenHeight * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "select_price".localeValue(context: context),
                                textDirection: context.isEnglish
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                style: AppTextStyles.filterTextStyle(
                                    context: context),
                              ),
                            ],
                          ),
                        ),
                        Consumer<CurrentIndexProvider>(
                          builder: (context, currentIndex, child) {
                            return Consumer<SearchingDrinksProvider>(
                              builder: (context, searchingDrink, child) {
                                return Consumer<SearchingSystemProvider>(
                                  builder: (context, searching, child) {
                                    return Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                filterPrice.allPricesFilter;
                                                currentIndex.currentIndex == 1
                                                    ? searchingDrink
                                                        .filterDrinke(
                                                            context: context)
                                                    : searching
                                                        .searchInCategory(
                                                            context: context);
                                                log("Selected : All");
                                              },
                                              child: FilterPriceContainer(
                                                imagePath:
                                                    "asstes/images/app_images/price_filter/all.svg",
                                                priceRange: "all_price"
                                                    .localeValue(
                                                        context: context),
                                                isSelected: filterPrice.isAll,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                filterPrice.cheapPricesFilter;
                                                currentIndex.currentIndex == 1
                                                    ? searchingDrink
                                                        .filterDrinke(
                                                            context: context)
                                                    : searching
                                                        .searchInCategory(
                                                            context: context);
                                                log("Selected : Cheap");
                                              },
                                              child: FilterPriceContainer(
                                                imagePath:
                                                    "asstes/images/app_images/price_filter/cheap.svg",
                                                priceRange: "cheap_price"
                                                    .localeValue(
                                                        context: context),
                                                isSelected: filterPrice.isCheap,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                filterPrice.mediumPricesFilter;
                                                currentIndex.currentIndex == 1
                                                    ? searchingDrink
                                                        .filterDrinke(
                                                        context: context,
                                                      )
                                                    : searching
                                                        .searchInCategory(
                                                        context: context,
                                                      );
                                                log("Selected : Medium");
                                              },
                                              child: FilterPriceContainer(
                                                imagePath:
                                                    "asstes/images/app_images/price_filter/medium.svg",
                                                priceRange: "medium_price"
                                                    .localeValue(
                                                        context: context),
                                                isSelected:
                                                    filterPrice.isMedium,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                filterPrice.highPricesFilter;
                                                currentIndex.currentIndex == 1
                                                    ? searchingDrink
                                                        .filterDrinke(
                                                        context: context,
                                                      )
                                                    : searching
                                                        .searchInCategory(
                                                        context: context,
                                                      );
                                                log("Selected : High");
                                              },
                                              child: FilterPriceContainer(
                                                imagePath:
                                                    "asstes/images/app_images/price_filter/expencive.svg",
                                                priceRange:
                                                    "high_price".localeValue(
                                                  context: context,
                                                ),
                                                isSelected: filterPrice.isHigh,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1.5,
                                ),
                                borderRadius: borderRaduis(10),
                                color: SwitchColors.filteredItemColor,
                              ),
                              child: Text(
                                filterPrice.priceRange(context: context),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: context.isEnglish
                                      ? FontFamily.mainFont
                                      : FontFamily.mainArabic,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Consumer<RattingProvider>(
                              builder: (context, rattingFilter, child) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 1.5,
                                    ),
                                    borderRadius: borderRaduis(10),
                                    color: SwitchColors.filteredItemColor,
                                  ),
                                  child: Text(
                                    rattingFilter.rattingFilter(
                                        context: context),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: context.isEnglish
                                          ? FontFamily.mainFont
                                          : FontFamily.mainArabic,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "select_rate".localeValue(context: context),
                                textDirection: context.isEnglish
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                style: AppTextStyles.filterTextStyle(
                                    context: context),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Consumer<RattingProvider>(
                              builder: (context, rattingFilter, child) {
                                return Column(
                                  children: [
                                    RadioListTile(
                                      value: RattingFilterEnum.any,
                                      groupValue: rattingFilter.selectedRate,
                                      title: Text(
                                        ratting[0]
                                            .title
                                            .localeValue(context: context),
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          fontFamily: context.isEnglish
                                              ? FontFamily.mainFont
                                              : FontFamily.mainArabic,
                                        ),
                                      ),
                                      subtitle: Text(
                                        ratting[0]
                                            .subTitle
                                            .localeValue(context: context),
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          fontFamily: context.isEnglish
                                              ? FontFamily.mainFont
                                              : FontFamily.mainArabic,
                                        ),
                                      ),
                                      onChanged: (anyRate) {
                                        rattingFilter.getUserRate(
                                          choosedRate:
                                              anyRate as RattingFilterEnum,
                                        );
                                      },
                                    ),
                                    RadioListTile(
                                      value: RattingFilterEnum.medium,
                                      groupValue: rattingFilter.selectedRate,
                                      title: Text(
                                        ratting[1]
                                            .title
                                            .localeValue(context: context),
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          fontFamily: context.isEnglish
                                              ? FontFamily.mainFont
                                              : FontFamily.mainArabic,
                                        ),
                                      ),
                                      subtitle: Text(
                                        ratting[1]
                                            .subTitle
                                            .localeValue(context: context),
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          fontFamily: context.isEnglish
                                              ? FontFamily.mainFont
                                              : FontFamily.mainArabic,
                                        ),
                                      ),
                                      onChanged: (goodRate) {
                                        rattingFilter.getUserRate(
                                          choosedRate:
                                              goodRate as RattingFilterEnum,
                                        );
                                      },
                                    ),
                                    RadioListTile(
                                      value: RattingFilterEnum.high,
                                      groupValue: rattingFilter.selectedRate,
                                      title: Text(
                                        ratting[2]
                                            .title
                                            .localeValue(context: context),
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          fontFamily: context.isEnglish
                                              ? FontFamily.mainFont
                                              : FontFamily.mainArabic,
                                        ),
                                      ),
                                      subtitle: Text(
                                        ratting[2]
                                            .subTitle
                                            .localeValue(context: context),
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          fontFamily: context.isEnglish
                                              ? FontFamily.mainFont
                                              : FontFamily.mainArabic,
                                        ),
                                      ),
                                      onChanged: (excellentRate) {
                                        rattingFilter.getUserRate(
                                          choosedRate: excellentRate
                                              as RattingFilterEnum,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class FilterPriceContainer extends StatelessWidget {
  const FilterPriceContainer({
    super.key,
    required this.imagePath,
    required this.priceRange,
    required this.isSelected,
  });

  final String imagePath;
  final String priceRange;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      width: context.screenWidth * .42,
      decoration: BoxDecoration(
        borderRadius: borderRaduis(20),
        color: isSelected
            ? SwitchColors.selectedFilterColor
            : SwitchColors.otherFiltersColor,
        border: isSelected
            ? Border.all(
                color: Colors.orange,
                width: 1.5,
              )
            : Border.all(
                color: Colors.grey,
                width: 1,
              ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: context.screenWidth * .1,
            height: context.screenHeight * .05,
            child: SvgPicture.asset(imagePath),
          ),
          Text(
            priceRange,
            style: AppTextStyles.filterItemTextStyle(
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
