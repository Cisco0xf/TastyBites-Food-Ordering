import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/data_layer/data_models/drinks_cold_demo_data.dart';
import 'package:foodapp/data_layer/data_models/drinks_hot_demo_data.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/searching_system/searchin_drink_provider.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/categories_widgets/drinks/tab_bar_widgets/type_drinks.dart';
import 'package:provider/provider.dart';

class DrinksWidget extends StatelessWidget {
  const DrinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Consumer<SearchingDrinksProvider>(
              builder: (context, searchingDrink, child) {
            return TabBar(
              onTap: (int type) {
                searchingDrink.clearTExtFeild();
                
                context.read<CurrentIndexProvider>().selectDrinsType(type);
              },
              dividerColor: const Color(0xFFEE5007),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: context.screenWidth * .07,
                        height: context.screenHeight * .04,
                        child: SvgPicture.asset(
                          "asstes/images/app_images/categories_images/cold_drinks.svg",
                        ),
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
                      SizedBox(
                        width: context.screenWidth * .07,
                        height: context.screenHeight * .03,
                        child: SvgPicture.asset(
                          "asstes/images/app_images/categories_images/hot_drinks.svg",
                        ),
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
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                TypeDrinksWidget(
                  typeDrinks: coldDrinksDemoData,
                ),
                TypeDrinksWidget(
                  typeDrinks: dirnksDemoData,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
