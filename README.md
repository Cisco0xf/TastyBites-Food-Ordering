# TastyBites - Food Ordering App

***A full-stack food delivery mobile application built with Flutter and Firebase.***

<div align="center">
  <img width="400" height="400" alt="playstore" src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/images/app_images/splash_screen-images/food_image_larg.png" />
<div align="center">

<p align="center">
   Tastybites | By Mahmoud Alshehyby
</p>

<div align="start">

## Overview

#### Simple food delivery app with real-time cart management, cloud sync, and multi-language support. Features Layered MVC and offline-first approach.


## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Framework** | Flutter 3.0+ | Cross-platform UI |
| **State Management** | Provider | Scalable state handling |
| **Backend** | Firebase | Authentication & Database |
| **Local Storage** | Hive | Offline data persistence |
| **Save user Prefs** | shared_preferences | Save user settings and preferences |
| **PDF Generation** | pdf | Receipt creation |
| **Localization** | flutter_localizations | Multi-language support |
| **Permissions** | permission_handler | Storage access |
| **UI Enhancements** | Various packages | Animations, icons, etc. |

## 📦 Installation

```bash
# Clone the repository
git clone https://github.com/Cisco0xf/TastyBites-Food-Ordering.git

# Navigate to project
cd food-delivery-app

# Install dependencies
flutter pub get

# Setup Firebase
# 1. Create Firebase project
# 2. Add iOS/Android apps
# 3. Download google-services.json & GoogleService-Info.plist
# 4. Place in correct directories
# 5. Or you can use Firebase CLI (Easy && Time Saver)

# Run the app
flutter run

```

## Dependencies
```yaml

dependencies:
  cloud_firestore: ^6.1.0
  cupertino_icons: ^1.0.2
  firebase_auth: ^6.1.2
  firebase_core: ^4.2.1
  firebase_messaging: ^16.0.4
  flutter:
    sdk: flutter
  flutter_credit_card: ^4.1.0 
  flutter_localizations:
    sdk: flutter
  flutter_native_splash: ^2.4.1
  flutter_rating_bar: ^4.0.1
  flutter_svg: ^2.0.10+1
  fluttertoast: ^8.2.4
  google_sign_in: ^6.2.1
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  intl: ^0.19.0
  loading_animation_widget: ^1.3.0
  lottie: ^3.1.0
  open_file: ^3.5.4
  path_provider: ^2.1.5
  pdf: ^3.11.3
  permission_handler: ^12.0.1
  provider: ^6.1.2
  scrollable_positioned_list: ^0.3.8
  shared_preferences: ^2.2.3
  shimmer: ^3.0.0
  smooth_page_indicator: ^1.1.0
  toastification: ^2.3.0

dev_dependencies:
  build_runner: ^2.4.9
  flutter_lints: ^2.0.0
  flutter_test:
    sdk: flutter
  hive_generator: ^2.0.1


```


## Features

### 🔐 **Authentication & Security**
- Email/password registration with verification
- Google sign in
- Secure login system
- Password update with reauthentication
- Account deletion (with security checks)

### 📊 **Data Management**
- Cloud cart & wishlist (Firestore)
- Local data caching (Hive)
- Offline fallback support
- Receipt generation & export (PDF)

### 🎨 User Experience
- Light/Dark mode
- Arabic & English localization
- Product search & filtering (price, rating)
- User profile management
- Modern, custom-designed UI


## Code Architecture

```text (Layerd Architecture)
FOODAPP/
└── lib/
    ├── common/
    │   ├── app_dimention.dart
    │   ├── commons.dart
    │   ├── gaps.dart
    │   ├── grid_item.dart
    │   ├── list_item.dart
    │   ├── my_logger.dart
    │   └── navigator_key.dart
    ├── constants/
    │   ├── app_colors.dart
    │   ├── assets.dart
    │   ├── enums.dart
    │   ├── fonts.dart
    │   ├── global_box_shadow.dart
    │   ├── input_decoration.dart
    │   ├── style.dart
    │   └── texts.dart
    ├── data_layer/
    │   ├── data_base/
    │   │   ├── receipt_db/
    │   │   │   ├── receipt_db.dart
    │   │   │   ├── receipt_model.dart
    │   │   │   └── receipt_model.g.dart
    │   │   └── shared_prefrence/
    │   │       ├── save_last_changes.dart
    │   │       ├── cart_list_database.dart
    │   │       └── global_demo_data_model.dart
    │   ├── data_models/
    │   │   ├── desserts_demo_data.dart
    │   │   ├── drinks_cold_demo_data.dart
    │   │   ├── drinks_hot_demo_data.dart
    │   │   ├── fast_food_demo_data.dart
    │   │   ├── food_demo_data.dart
    │   │   ├── global_dishes_model.dart
    │   │   ├── random_data.dart
    │   │   ├── salads_demo_data.dart
    │   │   ├── sushi_demo_data.dart
    │   │   └── vegetarian_dishes.dart
    │   ├── hive_keys.dart
    │   ├── global_demo_data_model.g.dart
    │   └── locale_repository.dart
    ├── presentation_layer/
    │   ├── auth/
    │   │   ├── components/
    │   │   │   ├── auth_social_media.dart
    │   │   │   ├── auth_wrapper.dart
    │   │   │   ├── custom_auth_button.dart
    │   │   │   ├── custom_text_feild.dart
    │   │   │   └── send_vrification_dialog.dart
    │   │   ├── forget_password/
    │   │   │   └── foget_password.dart
    │   │   ├── log_in/
    │   │   │   └── log_in_main_screen.dart
    │   │   ├── push_to_auth/
    │   │   │   └── push_auth_screen.dart
    │   │   └── sign_up/
    │   │       └── sign_up_main_screen.dart
    │   └── screens/
    │       ├── custom_nav_bar_screens/
    │       │   ├── custom_nav_bar_widgets/
    │       │   │   └── content_widgets.dart
    │       │   ├── favorite_items/
    │       │   │   ├── favorite_empty.dart
    │       │   │   ├── favorite_screen.dart
    │       │   │   └── item_widget.dart
    │       │   ├── food_notification/
    │       │   │   ├── empty_notifications.dart
    │       │   │   └── notifications_screen.dart
    │       │   ├── home_screen/
    │       │   │   ├── categories/
    │       │   │   │   ├── desserts/
    │       │   │   │   │   ├── desserts.dart
    │       │   │   │   │   └── desserts_details.dart
    │       │   │   │   ├── drinks/
    │       │   │   │   │   └── drinks.dart
    │       │   │   │   ├── fast_food/
    │       │   │   │   │   └── fast_food.dart
    │       │   │   │   ├── global_dishes/
    │       │   │   │   │   ├── food_slider.dart
    │       │   │   │   │   ├── global_body.dart
    │       │   │   │   │   ├── global_details.dart
    │       │   │   │   │   ├── global_dishes.dart
    │       │   │   │   │   └── ratting_sector.dart
    │       │   │   │   ├── salads_vegetarian/
    │       │   │   │   │   ├── details_of_dishes.dart
    │       │   │   │   │   └── show_dishes.dart
    │       │   │   │   ├── special_dishes/
    │       │   │   │   │   └── special_dishes.dart
    │       │   │   │   └── sushi/
    │       │   │   │       └── sushi_widget.dart
    │       │   │   └── components/
    │       │   │       ├── filtter_searching/
    │       │   │       │   ├── filter_sheet.dart
    │       │   │       │   ├── ratting_model.dart
    │       │   │       │   ├── search_field.dart
    │       │   │       │   └── searching_filter.dart
    │       │   │       ├── categories_items.dart
    │       │   │       ├── categories.dart
    │       │   │       ├── order_or_add_to_cart.dart
    │       │   │       ├── quantity_widget.dart
    │       │   │       └── home_widget.dart
    │       │   │       └── shimmers/
    │       │   │           └── main_screen_shimmer.dart
    │       │   ├── shopping_screen/
    │       │   │   ├── chick_out/
    │       │   │   │   ├── push_order_process/
    │       │   │   │   │   ├── order_cart.dart
    │       │   │   │   │   └── order_single_item.dart
    │       │   │   │   ├── resturent_or_delivery/
    │       │   │   │   │   ├── add_location.dart
    │       │   │   │   │   ├── choose_table.dart
    │       │   │   │   │   ├── order_place.dart
    │       │   │   │   │   ├── payment_card_list.dart
    │       │   │   │   │   └── tables_bottom_sheet.dart
    │       │   │   │   ├── chick_out.dart
    │       │   │   │   └── details_row.dart
    │       │   │   │   └── order_place_provider.dart
    │       │   │   ├── payment_screen/
    │       │   │   │   ├── payment_card.dart
    │       │   │   │   ├── recepit.dart
    │       │   │   │   └── success_payment.dart
    │       │   │   └── shopping_cart/
    │       │   │       ├── add_icon_btn.dart
    │       │   │       ├── added_to_cart.dart
    │       │   │       ├── cart_items.dart
    │       │   │       ├── empty_cart_screen.dart
    │       │   │       ├── price_details.dart
    │       │   │       ├── remove_item_from_cart.dart
    │       │   │       └── shopping_widget.dart
    │       │   └── user_profile_screen/
    │       │       ├── components/
    │       │       │   ├── profile_reusable_widget.dart
    │       │       │   ├── show_full_profile_image.dart
    │       │       │   └── show_log_out_dialog.dart
    │       │       ├── personal_info/
    │       │       │   ├── components/
    │       │       │   │   ├── change_user_info_widget.dart
    │       │       │   │   └── show_confirm_dailog.dart
    │       │       │   ├── delete_user_account/
    │       │       │   │   ├── confirm_user_deletion.dart
    │       │       │   │   └── delete_account_screen.dart
    │       │       │   ├── update_password/
    │       │       │   │   ├── new_password_screen.dart
    │       │       │   │   └── update_password.dart
    │       │       │   └── personal_info_screen.dart
    │       │       ├── receipts_history/
    │       │       │   ├── clear_receipt_dialog.dart
    │       │       │   ├── empty_history.dart
    │       │       │   ├── new_history_receipt.dart
    │       │       │   ├── receipt_history_widget.dart
    │       │       │   ├── receipt_info.dart
    │       │       │   └── receipt_jitem.dart
    │       │       └── settings/
    │       │           └── profile_widget.dart
    │       ├── main_screen/
    │       │   ├── custom_nav_bar_item.dart
    │       │   ├── main_screen.dart
    │       │   ├── show_exit_dialog.dart
    │       │   └── top_bar.dart
    │       └── spalsh_screen/
    │           └── splash_screen.dart
    ├── statemanagement/
    │   ├── add_to_cart/
    │   │   └── add_to_cart_provider.dart
    │   ├── authantications/
    │   │   ├── auth_controllers.dart
    │   │   ├── auth_operations.dart
    │   │   ├── auth_provider.dart
    │   │   └── authentication_provider.dart
    │   ├── cloud_firestore/
    │   │   ├── collections.dart
    │   │   ├── manage_metadata.dart
    │   │   └── sync_locale_with_cloud.dart
    │   │   └── cloud_messaging/
    │   ├── favoriter_items/
    │   │   └── add_to_favorite_provider.dart
    │   ├── localization/
    │   │   ├── language_of_app.dart
    │   │   ├── last_localization.dart
    │   │   ├── localization_delegate.dart
    │   │   └── localization_provider.dart
    │   ├── order_single_item/
    │   ├── receipt_management/
    │   │   ├── pdf_manager.dart
    │   │   ├── receipt_db.dart
    │   │   ├── receipt_history_provider.dart
    │   │   └── receipt_model.dart
    │   ├── save_received_notifications/
    │   │   ├── notifications_model.dart
    │   │   └── save_notifications.dart
    │   ├── searching_filter/
    │   │   ├── price_filter_provider.dart
    │   │   └── ratting_provider.dart
    │   ├── searching_system/
    │   │   ├── controllers_manager.dart
    │   │   └── searching_provider.dart
    │   ├── theming/
    │   │   ├── is_light.dart
    │   │   ├── save_last_theme.dart
    │   │   └── theme_provider.dart
    │   ├── user_address/
    │   │   └── get_user_address.dart
    │   ├── user_table/
    │   │   └── get_user_table.dart
    │   ├── app_providers.dart
    │   ├── current_index_provider.dart
    │   └── firebase_options.dart
    └── main.dart
```

## Screenshots

<table>
   <tr>
    <td align="center"><b>Splash Screen</b></td>
    <td align="center"><b>Auth Wrapper</b></td>
    <td align="center"><b>Log In</b></td>
    <td align="center"><b>Get Password Link</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/1-portrait.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/2-portrait.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/3-portrait.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/4-portrait.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>

<table>
   <tr>
    <td align="center"><b>Sign Up</b></td>
    <td align="center"><b>Verification Email</b></td>
    <td align="center"><b>Main Shimmer</b></td>
    <td align="center"><b>Main screen</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/5-portrait.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/7-portrait.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/6-portrait.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/8-portrait.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>

<table>
   <tr>
    <td align="center"><b>Search && Filtering</b></td>
    <td align="center"><b>Category</b></td>
    <td align="center"><b>Green Detials</b></td>
    <td align="center"><b>Food Details</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/9-portrait.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/10-portrait.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/11.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/12.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>

<table>
   <tr>
    <td align="center"><b>WishList screen</b></td>
    <td align="center"><b>Global Details</b></td>
    <td align="center"><b>Desserts</b></td>
    <td align="center"><b>Category</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/13.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/14.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/15.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/16.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>

<table>
   <tr>
    <td align="center"><b>Drinks</b></td>
    <td align="center"><b>Global</b></td>
    <td align="center"><b>Image Dialog</b></td>
    <td align="center"><b>Cart Screen</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/17.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/18.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/19.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/20.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>

<table>
   <tr>
    <td align="center"><b>Payment</b></td>
    <td align="center"><b>Payment data</b></td>
    <td align="center"><b>Success payment</b></td>
    <td align="center"><b>Delete confirmation</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/21.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/23.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/24.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/22.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>


<table>
   <tr>
    <td align="center"><b>Personal Info</b></td>
    <td align="center"><b>Receipts screen</b></td>
    <td align="center"><b>Checkout</b></td>
    <td align="center"><b>Confirmation</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/25.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/26.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/27.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/28.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>

<table>
   <tr>
    <td align="center"><b>Receitp</b></td>
    <td align="center"><b>Profile</b></td>
    <td align="center"><b>Settgins</b></td>
    <td align="center"><b>Dark Green</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/29.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/30.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/31.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/32.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>

<table>
   <tr>
    <td align="center"><b>Item ingredients</b></td>
    <td align="center"><b>Single item order</b></td>
    <td align="center"><b>Get PDF Receipt</b></td>
    <td align="center"><b>PDF Receipt</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/33.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/35.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/34.webp?raw=true" alt="Screen" width="300"/></td>
    <td><img src="https://github.com/Cisco0xf/TastyBites-Food-Ordering/blob/main/asstes/screenshots/36.webp?raw=true" alt="Screen" width="300"/></td>

  </tr>
 

</table>

## LICENSE
**MIT © Mahmoud Nagy**