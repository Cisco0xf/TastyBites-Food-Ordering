import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
import 'package:foodapp/statemanagement/user_address/get_user_address.dart';
import 'package:foodapp/statemanagement/user_table/get_user_table.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderSingleItemProvider with ChangeNotifier {
  // Cach the ordered item
  late FoodModel orderedItem;
  void item({required FoodModel item}) {
    orderedItem = item;
    notifyListeners();
  }

  // Get total price

  double get getTotalOrderPrice {
    double totalOrderPrice = 0;
    if (orderedItem.foodType == "Sushi") {
      totalOrderPrice = double.parse(
        (orderedItem.foodPrice * orderedItem.stock / 5).toStringAsFixed(2),
      );
    } else {
      totalOrderPrice = double.parse(
        (orderedItem.foodPrice * orderedItem.stock).toStringAsFixed(2),
      );
    }

    return totalOrderPrice;
  }

  // Get a discount accorrding to the stock

  double get offerDiscout {
    double offerDiscount = 0;
    if (orderedItem.stock >= 1 && orderedItem.stock <= 4) {
      offerDiscount = 8.23;
    } else if (orderedItem.stock >= 5 && orderedItem.stock <= 6) {
      offerDiscount = 13.42;
    } else {
      offerDiscount = 21.45;
    }
    return offerDiscount;
  }
  // Increase or Decrease the stock

  void increaseStock() {
    orderedItem.stock++;
    notifyListeners();
  }

  void decreaseStock({required BuildContext context}) {
    if (orderedItem.foodType == "Sushi") {
      if (orderedItem.stock == 5) {
        ReusableMethods.showtoastification(message: "Minimum quantity is 5");
      } else {
        orderedItem.stock--;
      }
    } else {
      if (orderedItem.stock == 1) {
        ReusableMethods.showtoastification(
          message: "Minimum quiantity 1",
        );
      } else {
        orderedItem.stock--;
      }
    }

    notifyListeners();
  }

  // Get the final price after discount and the service

  double getTotalPriceAfterDiscountAndService({bool idDelivery = false}) {
    double finalPrice = 0;
    if (idDelivery) {
      finalPrice = getTotalOrderPrice + 11 - offerDiscout;
    } else {
      finalPrice = getTotalOrderPrice + 5 - offerDiscout;
    }
    finalPrice = double.parse(finalPrice.toStringAsFixed(2));

    return finalPrice;
  }
  // Get single item price receipt

  String get getDateTime {
    String dateTime = DateFormat("MMM d, hh:mm aaa").format(DateTime.now());
    return dateTime;
  }
/* 
  bool isDelivary({required BuildContext context}) {
    PlaceProvider orderPlace =
        Provider.of<PlaceProvider>(context, listen: false);
    return orderPlace.isTakeAway;
  } */

  String orderPlace({required BuildContext context}) {
    String userDicision = "";

    AddressProvider address =
        Provider.of<AddressProvider>(context, listen: false);
    /* GetUserTableProvider table =
        Provider.of<GetUserTableProvider>(context, listen: false); */

    final bool isDelivary = context.read<PlaceProvider>().isTakeaway;

    if (isDelivary) {
      userDicision = "Deliveted to : ${address.userAddress}";
    } else {
      final String selectedTable = context.read<TableProvider>().selectedTable;
      userDicision = "Ordered at restuarant, table : $selectedTable";
    }

    return userDicision;
  }

  String singleOrderReceipt({required BuildContext context}) {
    StringBuffer receipt = StringBuffer();
    receipt.writeln("Thanks for your oreder");
    receipt.writeln("Here's your single order receipt");
    receipt.writeln("-" * 30);
    receipt.writeln(
        "${orderedItem.stock} x ${orderedItem.foodName} (\$ ${orderedItem.foodPrice})");
    receipt.writeln("-" * 30);
    receipt.writeln("Quantity : ${orderedItem.stock}");
    receipt.writeln("Offer Discount : $offerDiscout");
    context.read<PlaceProvider>().isTakeaway
        ? receipt.writeln("Delivery : \$ 11")
        : receipt.writeln("Service : \$ 5");
    receipt.writeln("-" * 30);
    receipt.writeln("Item price : ${getTotalPriceAfterDiscountAndService()}");
    receipt.writeln("-" * 30);
    receipt.writeln(orderPlace(context: context));

    String orderReceipt = receipt.toString();
    return orderReceipt;
  }
}
