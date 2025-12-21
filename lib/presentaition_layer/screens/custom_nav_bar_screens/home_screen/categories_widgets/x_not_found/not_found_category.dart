import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories_items.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class NotFounCategoryWidget extends StatelessWidget {
  const NotFounCategoryWidget({super.key});


  @override
  Widget build(BuildContext context) {

    final int currentCategory = context.watch<CurrentIndexProvider>().currentIndex;

    final String categoryLabel = categoriesItems[currentCategory].itemTitle;

    final String localizedCat = categoryLabel.localeValue(context: context);

    final String label =
        "${"not_found".localeValue(context: context)} \"$localizedCat\"";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: context.screenWidth * .88,
          height: context.screenHeight * .3,
          child: SvgPicture.asset(Assets.emptyCart),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: context.isEnglish ? 20 : 17,
            fontFamily:
                context.isEnglish ? FontFamily.coolFont : FontFamily.mainArabic,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(height: 20),
        Consumer<SearchingProvider>(
          builder: (context, clearSearching, child) {
            return SizedBox(
              width: context.screenWidth * .6,
              height: context.screenHeight * .06,
              child: MaterialButton(
                onPressed: () => clearSearching.clearFilterAndSearch(),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRaduis(15),
                ),
                color: SwitchColor.primaryO,
                child: Text(
                  "see_recomended".localeValue(context: context),
                  style: TextStyle(
                    fontSize: context.isEnglish ? 15 : 17,
                    fontFamily:
                        context.isEnglish ? null : FontFamily.mainArabic,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
