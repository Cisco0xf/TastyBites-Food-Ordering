import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/authantications/authentication_provider.dart';
import 'package:foodapp/statemanagement/cloud_messaging/notification_messaging.dart';
import 'package:foodapp/statemanagement/current_index_provider.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:foodapp/statemanagement/localization/localization_provider.dart';
import 'package:foodapp/statemanagement/order_single_item/order_single_item_provider.dart';
import 'package:foodapp/statemanagement/profile_seetings/presonal_info_provider.dart';
import 'package:foodapp/statemanagement/save_received_notifications/save_notifications.dart';
import 'package:foodapp/statemanagement/searching_filter/price_filter_provider.dart';
import 'package:foodapp/statemanagement/searching_filter/ratting_provider.dart';
import 'package:foodapp/statemanagement/searching_system/searchin_drink_provider.dart';
import 'package:foodapp/statemanagement/searching_system/searching_provider.dart';
import 'package:foodapp/statemanagement/theming/theme_provider.dart';
import 'package:foodapp/statemanagement/user_address/get_user_address.dart';
import 'package:foodapp/statemanagement/user_table/get_user_table.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_history_provider.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get appProviders {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => AddressProvider()),
    //ChangeNotifierProvider(create: (context) => ReceiptHistoryProvider()),
    ChangeNotifierProvider(create: (context) => OrderSingleItemProvider()),
    //ChangeNotifierProvider(create: (context) => SearchingSystemProvider()),//
    // ChangeNotifierProvider(create: (context) => SearchingFilterProvider()),
    // ChangeNotifierProvider(create: (context) => SearchingDrinksProvider()),//
    ChangeNotifierProvider(create: (context) => RattingProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => LocalizationProvider()),
    ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
    ChangeNotifierProvider(create: (context) => PersonalInfoProvider()),
    ChangeNotifierProvider(create: (context) => NotificationProvider()),
    ChangeNotifierProvider(create: (context) => SaveNotificationsProvider()),

    ///
    ChangeNotifierProvider(create: (context) => CurrentIndexProvider()),
    ChangeNotifierProvider(create: (context) => PlaceProvider()),
    ChangeNotifierProvider(create: (context) => TableProvider()),
    ChangeNotifierProvider(create: (context) => WishListProvider()),
    ChangeNotifierProvider(create: (context) => CartManager(context)),
    ChangeNotifierProvider(create: (context) => PriceFilterProvider()),
    ChangeNotifierProvider(create: (context) => SearchingProvider()),
    ChangeNotifierProvider(create: (context) => ManageReceiptHistory())
  ];

  return providers;
}
