import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories_items.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/constants/style.dart';

import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CategoriesSectorWidget extends StatefulWidget {
  const CategoriesSectorWidget({super.key});

  @override
  State<CategoriesSectorWidget> createState() => _CategoriesSectorWidgetState();
}

class _CategoriesSectorWidgetState extends State<CategoriesSectorWidget> {
  ItemScrollController scrollToCategoryController = ItemScrollController();

  void _scrollToCategory({
    required int index,
    double alignment = 0.25,
  }) {
    scrollToCategoryController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 200),
      alignment: alignment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentIndexProvider>(builder: (context, currentIndex, _) {
      return PopScope(
        onPopInvokedWithResult: (didPop, results) {
          bool isFirstCategory = currentIndex.currentIndex == 0;
          if (!isFirstCategory) {
            currentIndex.getNewIndex(newIndex: 0);
            scrollToCategoryController.scrollTo(
              index: 0,
              duration: const Duration(milliseconds: 230),
            );
            return;
          }
        },
        child: SizedBox(
          width: double.infinity,
          height: context.screenHeight * .07,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: ScrollablePositionedList.builder(
              key: const PageStorageKey("categories_key"),
              itemScrollController: scrollToCategoryController,
              scrollDirection: Axis.horizontal,
              itemCount: categoriesItems.length,
              minCacheExtent: context.screenWidth * .45,
              itemBuilder: (context, index) {
                return Consumer<CurrentIndexProvider>(
                  builder: (context, currentIndex, child) {
                    return Consumer<SearchingSystemProvider>(
                      builder: (context, searching, child) {
                        return GestureDetector(
                          onTap: () {
                            currentIndex.getNewIndex(newIndex: index);
                            searching.searchInCategory(context: context);
                            _scrollToCategory(index: index);
                          },
                          child: AnimatedContainer(
                            width: context.screenWidth * .45,
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: borderRaduis(20),
                              border: index == currentIndex.currentIndex
                                  ? Border.all(
                                      color: const Color(0xFFff3d00),
                                      width: 2,
                                    )
                                  : Border.all(
                                      color: Colors.transparent,
                                      width: 0,
                                    ),
                              color: const Color(0xFFFF7800).withOpacity(
                                index == currentIndex.currentIndex ? 1.0 : 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: context.screenWidth * .1,
                                  height: context.screenHeight * .04,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.asset(
                                    categoriesItems[index].itemImage,
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: index == currentIndex.currentIndex
                                      ? 1.0
                                      : 0.5,
                                  child: Text(
                                    categoriesItems[index]
                                        .itemTitle
                                        .localeValue(context: context),
                                    style: AppTextStyles.categoriesTextStyle(
                                      context: context,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
