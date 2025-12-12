import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/drinks/tab_bar_widgets/type_drinks.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:provider/provider.dart';

class DrinksWidget extends StatelessWidget {
  const DrinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<SearchingProvider>();

    context.watch<CurrentIndexProvider>();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Consumer<SearchingProvider>(builder: (context, search, _) {
            return TabBar(
              onTap: (int type) {
                search.filtesearchWithFilterCategoriesItems();

                context.read<CurrentIndexProvider>().selectDrinsType(type);
              },
              dividerColor: const Color(0xFFEE5007),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox.square(
                        dimension: context.screenHeight * .04,
                        child: SvgPicture.asset(Assets.oldDrinks),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Text("Cold drinks"),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox.square(
                        dimension: context.screenHeight * .04,
                        child: SvgPicture.asset(Assets.hotDrinks),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Text("Hot drinks"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            width: double.infinity,
            height: context.screenHeight * .6,
            child: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                TypeDrinksWidget(),
                TypeDrinksWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
