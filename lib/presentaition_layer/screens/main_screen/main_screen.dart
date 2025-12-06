import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/custom_nav_bar_widgets/content_widgets.dart';
import 'package:foodapp/presentaition_layer/screens/main_screen/custom_nav_bar_item.dart';
import 'package:foodapp/presentaition_layer/screens/main_screen/top_bar.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/cloud_messaging/notification_messaging.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/presentaition_layer/screens/main_screen/show_exit_dialog.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final NotificationProvider notificationProvider;

  @override
  void initState() {
    notificationProvider = Provider.of<NotificationProvider>(
      context,
      listen: false,
    );
    notificationProvider.showNotificationWhileApplicationIsOpen(
      context: context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int cartCounter = context.watch<CartManager>().state.length;

    return Consumer<CurrentIndexProvider>(
      builder: (context, currentIndex, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            bool isHome = currentIndex.currentContent == 0;

            bool isFirstCategory = currentIndex.currentIndex == 0;

            if (!isHome) {
              currentIndex.switchContent(1);
              return;
            }

            if (!isFirstCategory) {
              return;
            }

            if (!didPop) {
              await showExitDialog;
              return;
            }

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: Column(
              children: <Widget>[
                const MainScreenAppBar(),
                contentWidgets[currentIndex.currentContent].targetWidget,
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              decoration: BoxDecoration(
                color: Colors.orange[600],
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                      onPressed: () {
                        currentIndex.switchContent(3);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: context.isLight
                            ? Colors.black87
                            : const Color(0xFF6B728E),
                        size: 35,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: -5,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                        shape: BoxShape.circle,
                        color: context.isLight
                            ? Colors.blueGrey[200]
                            : const Color(0xFF263238),
                      ),
                      child: Text(
                        cartCounter.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              padding: const EdgeInsets.only(bottom: 10),
              surfaceTintColor: Colors.white,
              height: context.screenHeight * .08,
              notchMargin: 5.0,
              shape: const CircularNotchedRectangle(),
              child: IconTheme(
                data: const IconThemeData(
                  color: Color(0xFFFF7800),
                  size: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    CustomNavigationBarItem(
                      selectedColor: currentIndex.currentContent == 0
                          ? SwitchColors.selectedNavColor
                          : null,
                      icon: currentIndex.currentContent == 0
                          ? const Icon(
                              Icons.home,
                            )
                          : const Icon(
                              Icons.home_outlined,
                            ),
                      onPressed: () {
                        currentIndex.switchContent(1);
                      },
                    ),
                    CustomNavigationBarItem(
                      selectedColor: currentIndex.currentContent == 1
                          ? SwitchColors.selectedNavColor
                          : null,
                      icon: currentIndex.currentContent == 1
                          ? const Icon(Icons.favorite)
                          : const Icon(
                              Icons.favorite_outline,
                            ),
                      onPressed: () {
                        currentIndex.switchContent(2);
                      },
                    ),
                    SizedBox(
                      width: context.screenWidth * .12,
                    ),
                    CustomNavigationBarItem(
                      selectedColor: currentIndex.currentContent == 3
                          ? SwitchColors.selectedNavColor
                          : null,
                      icon: currentIndex.currentContent == 3
                          ? const Icon(
                              Icons.notifications,
                            )
                          : const Icon(
                              Icons.notifications_none_outlined,
                            ),
                      onPressed: () {
                        currentIndex.switchContent(4);
                      },
                    ),
                    CustomNavigationBarItem(
                      selectedColor: currentIndex.currentContent == 4
                          ? SwitchColors.selectedNavColor
                          : null,
                      icon: currentIndex.currentContent == 4
                          ? const Icon(Icons.person_2)
                          : const Icon(
                              Icons.person_2_outlined,
                            ),
                      onPressed: () {
                        currentIndex.switchContent(5);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
