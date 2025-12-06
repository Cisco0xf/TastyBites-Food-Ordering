import 'package:flutter/material.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/home_screen/home_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/foos_vedios_scree/notifications_screen.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/shopping_cart/shopping_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/user_profile_screen/profile_widget.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/favotie_items/favorite_screen.dart';

class BottomNavigationBarWidgets {
  final Widget targetWidget;
  final String widgetTitle;
  const BottomNavigationBarWidgets({
    required this.targetWidget,
    required this.widgetTitle,
  });
}

List<BottomNavigationBarWidgets> contentWidgets =
    const <BottomNavigationBarWidgets>[
  BottomNavigationBarWidgets(
    targetWidget: HomeWidget(),
    widgetTitle: "home",
  ),
  BottomNavigationBarWidgets(
    targetWidget: FavoriteItemsScreen(),
    widgetTitle: "favorite_items",
  ),
  BottomNavigationBarWidgets(
    targetWidget: CartWidget(),
    widgetTitle: "my_cart",
  ),
  BottomNavigationBarWidgets(
    targetWidget: NotificationsWidget(),
    widgetTitle: "notifications",
  ),
  BottomNavigationBarWidgets(
    targetWidget: UserProfileWidget(),
    widgetTitle: "my_profile",
  ),
];
