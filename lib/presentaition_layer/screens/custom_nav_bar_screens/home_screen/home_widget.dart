import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/filtter_searching/search_field.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/components/categories_items.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/searching_system/controllers_manager.dart';
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
  late final SearchingProvider search;
  @override
  void initState() {
    search = Provider.of<SearchingProvider>(context, listen: false);
    ControllersManager.initSearhcingControllers();
    super.initState();
  }

  @override
  void dispose() {
    ControllersManager.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SearchingProvider>();

    return Consumer<SearchingProvider>(builder: (context, ref, __) {
      return Expanded(
        child: Container(
          padding: padding(10, from: From.vertical),
          decoration: BoxDecoration(
            color: SwitchColors.backgroundMianColor,
            borderRadius: borderRaduis(15.0, side: Side.top),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: padding(10, from: From.horizontal),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SearchField(),
                    SearchingFilterWidget(),
                  ],
                ),
              ),
              const Gap(hRatio: 0.01),
              const CategoriesSectorWidget(),
              Consumer<CurrentIndexProvider>(
                builder: (context, currentIndex, child) {
                  return categoriesItems[currentIndex.currentIndex]
                      .targetWidget;
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
