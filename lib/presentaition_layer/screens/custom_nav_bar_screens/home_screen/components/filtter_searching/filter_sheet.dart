import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/common/navigator_key.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/constants/style.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/filtter_searching/ratting_model.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/filtter_searching/searching_filter.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/searching_filter/price_filter_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/ratting_provider.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:provider/provider.dart';

void showFilterSheet() {
  final BuildContext context = navigationKey.currentContext as BuildContext;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: context.screenHeight * .7,
    ),
    builder: (context) => const FilterSheet(),
  );
}

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PriceFilterProvider>(
      builder: (context, filterPrice, child) {
        return Column(
          children: <Widget>[
            const Gap(hRatio: 0.02),
            Padding(
              padding: padding(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "select_price".localeValue(context: context),
                    textDirection: context.isEnglish
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: AppTextStyles.filterTextStyle(context: context),
                  ),
                ],
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              children: <Widget>[
                for (int f = 0; f < priceFilters.length; f++) ...{
                  SelectPriceFilter(
                    onSelect: () {
                      filterPrice.selectFilter(f);

                      context
                          .read<SearchingProvider>()
                          .filtesearchWithFilterCategoriesItems();
                    },
                    priceRange: priceFilters[f].type,
                    imagePath: priceFilters[f].imagePath,
                    isSelected: filterPrice.currentFilter == f,
                  ),
                },
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: padding(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 1.5,
                    ),
                    borderRadius: borderRaduis(10),
                    color: SwitchColor.accent,
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
                      padding: padding(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 1.5,
                        ),
                        borderRadius: borderRaduis(10),
                        color: SwitchColor.accent,
                      ),
                      child: Text(
                        rattingFilter.rattingFilter(),
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
              padding: padding(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "select_rate".localeValue(context: context),
                    textDirection: context.isEnglish
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: AppTextStyles.filterTextStyle(context: context),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<RattingProvider>(
                  builder: (context, rattingFilter, child) {
                    return Column(
                      children: <Widget>[
                        for (int f = 0; f < ratting.length; f++) ...{
                          SelectRateFilter(
                            onFilter: (filter) {
                              rattingFilter.getUserRate(choosedRate: filter!);
                            },
                            value: rattingFilter.selectedRate,
                            subTitle: ratting[f].subTitle,
                            title: ratting[f].title,
                            filter: ratting[f].type,
                          ),
                        },
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
  }
}

class SelectRateFilter extends StatelessWidget {
  const SelectRateFilter({
    super.key,
    required this.onFilter,
    required this.value,
    required this.subTitle,
    required this.title,
    required this.filter,
  });

  final RateFilter? value;
  final String title;
  final RateFilter filter;
  final String subTitle;
  final void Function(RateFilter? filter) onFilter;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: filter,
      groupValue: value,
      title: Text(
        title.localeValue(context: context),
        style: TextStyle(
          letterSpacing: 0,
          fontFamily:
              context.isEnglish ? FontFamily.mainFont : FontFamily.mainArabic,
        ),
      ),
      subtitle: Text(
        subTitle.localeValue(context: context),
        style: TextStyle(
          letterSpacing: 0,
          fontFamily:
              context.isEnglish ? FontFamily.mainFont : FontFamily.mainArabic,
        ),
      ),
      onChanged: onFilter,
    );
  }
}
