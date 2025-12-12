import 'package:flutter/material.dart';
import 'package:foodapp/data_layer/data_base/cart_list_database.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_base/hive_keys.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
import 'package:foodapp/statemanagement/user_address/get_user_address.dart';
import 'package:foodapp/statemanagement/user_table/get_user_table.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class CartManager extends ChangeNotifier {
  List<FoodModel> state = [];

  final BuildContext context;

  CartManager(this.context);

  final ManageCartDB cartDb = ManageCartDB(HiveKeys.CART_KEY);

  Future<void> addFoodItemToCart(FoodModel food) async {
    final bool isExist = state.any((item) => item.id == food.id);

    if (isExist) {
      removeItemFromCart(food);

      return;
    }

    state = [...state, food];
    notifyListeners();

    ReusableMethods.showtoastification(
      message: "Item has been added to cart",
      type: ToastificationType.success, 
    );

    await cartDb.addDBItem(food);
  }

  Future<void> removeItemFromCart(FoodModel food) async {
    state = [
      for (int i = 0; i < state.length; i++) ...{
        if (state[i].id != food.id) state[i],
      }
    ];

    notifyListeners();

    ReusableMethods.showtoastification(
      message: "Item has been removed from cart",
    );

    await cartDb.removeDBItem(food);
  }

  Future<void> clearCart() async {
    state = [];

    notifyListeners();

    context.read<TableProvider>().clearTable();
    context.read<AddressProvider>().clearAddress();

    await cartDb.clearDb();
  }

  void initializeCartFromDatabase(List<FoodModel> db) {
    state = db;
  }

  void increaseQnt(FoodModel food) {
    state = [
      for (int i = 0; i < state.length; i++) ...{
        if (food.id == state[i].id)
          state[i].copyWith(stock: state[i].stock + 1)
        else
          state[i]
      }
    ];

    notifyListeners();
  }

  void decreaseQnt(FoodModel food) {
    for (int i = 0; i < state.length; i++) {
      final bool isSushi = state[i].foodType == "Sushi";

      final bool isTarget = state[i].id == food.id;

      if (isSushi && isTarget) {
        final bool sushiStok = state[i].stock > 5;
        if (sushiStok) {
          state[i].copyWith(stock: state[i].stock - 1);
        } else {
          ReusableMethods.showtoastification(
            message: "Sush Quantity must be >= 5",
          );
        }
      }

      if (isTarget && state[i].stock > 0) {
        state[i].copyWith(stock: state[i].stock - 1);
      }
    }

    notifyListeners();
  }

  String get selectedTable => context.read<TableProvider>().selectedTable;
  String get userAddress => context.read<AddressProvider>().userAddress;
  bool get isTakeaway => context.read<PlaceProvider>().isTakeaway;

  double get getTotlaPrice {
    double total = 0;

    for (int i = 0; i < state.length; i++) {
      if (state[i].foodType == "Sushi") {
        total += state[i].foodPrice * state[i].stock / 5;
      } else {
        total += state[i].foodPrice * state[i].stock;
      }
    }
    total = double.parse(total.toStringAsFixed(2)).toDouble();
    return total;
  }

  double get disCount {
    double disCount = 0;
    if (getTotlaPrice < 25.0 && getTotlaPrice > 0) {
      disCount = 0;
    } else if (getTotlaPrice > 25.0 && getTotlaPrice < 50.0) {
      disCount = 10.99;
    } else if (getTotlaPrice > 50.0 && getTotlaPrice < 150.0) {
      disCount = 20.0;
    } else {
      disCount = 50.0;
    }
    return disCount;
  }

  double get orderTotlAfterDiscount {
    double orderTotal = getTotlaPrice - disCount;

    orderTotal = double.parse(orderTotal.toStringAsFixed(2)).toDouble();
    return orderTotal;
  }

  double getOrderTotalArterDiscountAndService() {
    double orderTotal = 0;

    if (isTakeaway) {
      orderTotal = orderTotlAfterDiscount + 11;
    } else {
      orderTotal = orderTotlAfterDiscount + 5;
    }

    return double.parse(orderTotal.toStringAsFixed(2));
  }
  // Get the receipt && its components

  String get _getRecepitDateTime {
    String recepitDateTime = DateFormat("MMM d, hh:mm aaa").format(
      DateTime.now(),
    );
    return recepitDateTime;
  }

  String get dateTime => _getRecepitDateTime;

  String getRecepit({required BuildContext context, bool isHistory = false}) {
    final StringBuffer recepit = StringBuffer();

    isHistory ? null : recepit.writeln("Ordered in : $_getRecepitDateTime");
    recepit.writeln("Thanks for your order.");
    recepit.writeln("Here's your recepit");
    recepit.writeln("---------------------------------------");
    for (int j = 0; j < state.length; j++) {
      recepit.writeln(
        "${state[j].stock} x ${state[j].foodName} ( \$ ${state[j].foodPrice})",
      );
    }

    recepit.writeln("---------------------------------------");
    recepit.writeln("Total items : ${state.length}");
    recepit.writeln("Discount : \$ ${disCount.toString()}");
    recepit.writeln(serviceOrDelivery());
    recepit.writeln("---------------------------------------");
    recepit.writeln(
      "Total price : \$ ${getOrderTotalArterDiscountAndService()}",
    );
    recepit.writeln("---------------------------------------");

    if (isHistory) {
      recepit.writeln(orderPlace());
    }

    return recepit.toString();
  }

  // Chick the user choice

  String orderPlace() {
    if (isTakeaway) {
      return ("Delivered to $userAddress");
    }
    return ("Ordered at the restaurant, table $selectedTable");
  }

  String serviceOrDelivery() {
    if (isTakeaway) {
      return "Delivery : \$ 11";
    }
    return "Service : \$ 5";
  }
}

/* 
class AddToCartProvider with ChangeNotifier {
  List<FoodModel> cartItems = [];

  final CartListDataBase _cartDataBase = CartListDataBase();

  CartListDataBase get cartDataBase => _cartDataBase;

  // Add item to cart && Datadase

  Future<void> addItemToCart({
    required FoodModel addedItem,
    required BuildContext context,
  }) async {
    if (cartItems.contains(addedItem)) {
      removeItemFromCart(removedItem: addedItem);
      ReusableMethods.showtoastification(
        context: context,
        message: "Item removed from cart",
      );

      //remove item from dataBase
      Box box = await cartDataBase.openBox();
      cartDataBase.removeItemFromBox(
        box: box,
        item: addedItem,
      );
    } else {
      cartItems.add(addedItem);
      showModalBottomSheet(
        constraints: BoxConstraints(
          maxHeight: context.screenHeight * .37,
        ),
        context: context,
        builder: (context) {
          return AddedToCartSuccessfullyWidget(
            item: addedItem,
          );
        },
      );
      // add item to dataBase
      Box box = await cartDataBase.openBox();
      cartDataBase.putItemInBox(
        box: box,
        item: addedItem,
      );
    }
    notifyListeners();
  }

  // Remove item from cart && Database

  Future<void> removeItemFromCart({required FoodModel removedItem}) async {
    cartItems.remove(removedItem);
    // remove item from database
    Box box = await cartDataBase.openBox();
    cartDataBase.removeItemFromBox(
      box: box,
      item: removedItem,
    );
    notifyListeners();
  }

  // Clear the cart && the Database

  Future<void> clearCart() async {
    cartItems.clear();
    // Clear te DataBase
    Box box = await cartDataBase.openBox();
    cartDataBase.clearBox(box: box);
    notifyListeners();
  }

  // Initialization DataBase

  Future<void> initializationDataBase() async {
    Box box = await cartDataBase.openBox();
    List<FoodModel> lastCartList = cartDataBase.getDataFromBox(box: box);
    cartItems = lastCartList;
    notifyListeners();
  }

  // Get the total price of the products && CHICKOUT

  double get getTotlaPrice {
    double total = 0;

    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].foodType == "Sushi") {
        total += cartItems[i].foodPrice * cartItems[i].stock / 5;
      } else {
        total += cartItems[i].foodPrice * cartItems[i].stock;
      }
    }
    total = double.parse(total.toStringAsFixed(2)).toDouble();
    return total;
  }

  double get disCount {
    double disCount = 0;
    if (getTotlaPrice < 25.0 && getTotlaPrice > 0) {
      disCount = 0;
    } else if (getTotlaPrice > 25.0 && getTotlaPrice < 50.0) {
      disCount = 10.99;
    } else if (getTotlaPrice > 50.0 && getTotlaPrice < 150.0) {
      disCount = 20.0;
    } else {
      disCount = 50.0;
    }
    return disCount;
  }

  double get orderTotlAfterDiscount {
    double orderTotal = getTotlaPrice - disCount;

    orderTotal = double.parse(orderTotal.toStringAsFixed(2)).toDouble();
    return orderTotal;
  }

  double getOrderTotalArterDiscountAndService({required BuildContext context}) {
    OrderPlaceProvider orderPlace =
        Provider.of<OrderPlaceProvider>(context, listen: false);
    double orderTotal = 0;

    if (orderPlace.isTakeAway) {
      orderTotal = orderTotlAfterDiscount + 11;
    } else {
      orderTotal = orderTotlAfterDiscount + 5;
    }

    return double.parse(orderTotal.toStringAsFixed(2));
  }
  // Get the receipt && its components

  String get _getRecepitDateTime {
    String recepitDateTime = DateFormat("MMM d, hh:mm aaa").format(
      DateTime.now(),
    );
    return recepitDateTime;
  }

  String get dateTime => _getRecepitDateTime;

  String getRecepit({required BuildContext context, bool isHistory = false}) {
    final StringBuffer recepit = StringBuffer();

    isHistory ? null : recepit.writeln("Ordered in : $_getRecepitDateTime");
    recepit.writeln("Thanks for your order.");
    recepit.writeln("Here's your recepit");
    recepit.writeln("---------------------------------------");
    for (int j = 0; j < cartItems.length; j++) {
      recepit.writeln(
        "${cartItems[j].stock} x ${cartItems[j].foodName} ( \$ ${cartItems[j].foodPrice})",
      );
    }

    recepit.writeln("---------------------------------------");
    recepit.writeln("Total items : ${cartItems.length}");
    recepit.writeln("Discount : \$ ${disCount.toString()}");
    recepit.writeln(serviceOrDelivery(context: context));
    recepit.writeln("---------------------------------------");
    recepit.writeln(
      "Total price : \$ ${getOrderTotalArterDiscountAndService(context: context)}",
    );
    recepit.writeln("---------------------------------------");
    isHistory
        ? recepit.writeln(
            orderPlace(context: context),
          )
        : null;

    return recepit.toString();
  }

  // Chick the user choice

  String orderPlace({required BuildContext context}) {
    OrderPlaceProvider orderPlace =
        Provider.of<OrderPlaceProvider>(context, listen: false);
    AddressProvider address =
        Provider.of<AddressProvider>(context, listen: false);
    GetUserTableProvider userTable = Provider.of<GetUserTableProvider>(
      context,
      listen: false,
    );
    if (orderPlace.isRasturent) {
      return ("Ordered at the restaurant, table ${userTable.selectedTable}");
    } else {
      return ("Delivered to ${address.userAddress}");
    }
  }

  String serviceOrDelivery({required BuildContext context}) {
    OrderPlaceProvider orderplace =
        Provider.of<OrderPlaceProvider>(context, listen: false);
    if (orderplace.isTakeAway) {
      return "Delivery : \$ 11";
    } else {
      return "Service : \$ 5";
    }
  }
  // Get total price of Single item

  double getTotalPriceOfSingleItem({required BuildContext context}) {
    OrderSingleItemProvider singleOrder =
        Provider.of<OrderSingleItemProvider>(context, listen: false);

    double singleOrderPrice =
        singleOrder.getTotalPriceAfterDiscountAndService();

    return singleOrderPrice;
  }

  // Get item quantity

  void increaseQuantity({required int index}) {
    cartItems[index].stock++;
    notifyListeners();
  }

  void decreaseQuantity({
    required int index,
    required BuildContext context,
  }) {
    if (cartItems[index].foodType == "Sushi") {
      if (cartItems[index].stock == 5) {
        ReusableMethods.showtoastification(
          context: context,
          message: "stock_sushi".localeValue(
            context: context,
          ),
        );
      } else {
        cartItems[index].stock--;
      }
    } else {
      if (cartItems[index].stock == 1) {
        ReusableMethods.showtoastification(
          context: context,
          message: "stock_item".localeValue(
            context: context,
          ),
        );
      } else {
        cartItems[index].stock--;
      }
    }

    notifyListeners();
  }

  // Using the constructor to intialize the Database

  AddToCartProvider() {
    initializationDataBase();
  }
}
 */