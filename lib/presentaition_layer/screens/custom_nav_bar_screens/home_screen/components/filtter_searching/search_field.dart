import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories_items.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: context.screenHeight * .06,
        child: Consumer<CurrentIndexProvider>(
          builder: (context, currentIndex, child) {
            String hintText =
                "${"search".localeValue(context: context)} \"${categoriesItems[currentIndex.currentIndex].itemTitle.localeValue(
                      context: context,
                    )}\" ${context.isArabicEg ? "؟" : ""}";
                    
            return TextField(
              controller: context.read<SearchingProvider>().searchController,
              onChanged: (_) {
                context
                    .read<SearchingProvider>()
                    .filtesearchWithFilterCategoriesItems();
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
                fillColor: SwitchColors.searchFieldFillColor,
                filled: true,
                hintText: hintText,
                hintStyle: context.isEnglish
                    ? const TextStyle(fontSize: 15)
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
        ),
      ),
    );
  }
}
