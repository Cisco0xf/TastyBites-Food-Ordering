import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/payment_screen/payment_card.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/common/reusable_methods.dart';
import 'package:foodapp/statemanagement/user_address/get_user_address.dart';
import 'package:foodapp/statemanagement/user_table/get_user_table.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/push_order_process/order_cart.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/push_order_process/order_single_item.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/resturent_or_delivery/add_location.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/resturent_or_delivery/choose_table.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/resturent_or_delivery/order_place.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/order_place_provider.dart';

import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/resturent_or_delivery/payment_card_list.dart';
import 'package:foodapp/presentaition_layer/widgets/main_button.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ChickOutWidget extends StatefulWidget {
  const ChickOutWidget({
    super.key,
    required this.isSingleItem,
  });

  final bool isSingleItem;

  @override
  State<ChickOutWidget> createState() => _ChickOutWidgetState();
}

class _ChickOutWidgetState extends State<ChickOutWidget> {
  Widget get _gap =>
      widget.isSingleItem ? const Gap(hRatio: 0.01) : const Gap(hRatio: 0.05);

  late final AddressProvider address;

  @override
  void initState() {
    address = Provider.of(context, listen: false)..initAddressController();

    super.initState();
  }

  @override
  void dispose() {
    address
      ..disposeController()
      ..clearError();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.chickoutAppBarColor,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
        child: Consumer<PlaceProvider>(
          builder: (context, orderPlace, child) {
            return Container(
              width: context.screenWidth,
              height: context.screenHeight,
              padding: EdgeInsets.only(
                top: context.screenHeight * .04,
              ),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    bottom: null,
                    child: Container(
                      height: context.screenHeight * .11,
                      decoration: BoxDecoration(
                        color: SwitchColors.chickoutAppBarColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios, size: 35),
                          ),
                          const Gap(wRatio: .2),
                          const Text(
                            "CHICKOUT",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: context.screenHeight * .1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRaduis(15.0, side: Side.top),
                        color: SwitchColors.chickoutOrderPlaceColor,
                      ),
                      child: Column(
                        children: <Widget>[
                          const OrderPlaceWidget(),
                          orderPlace.isTakeaway
                              ? const AddLocaltionWidget()
                              : const ChoosTableWidget(),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: SwitchColors.chickoutDetailsColor,
                                  borderRadius:
                                      borderRaduis(15.0, side: Side.top),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    widget.isSingleItem
                                        ? const OrderSingleItemWidget()
                                        : const OrderAllCartWidget(),
                                    _gap,
                                    const PaymentsMethods(),
                                    _gap,
                                    PayManager(
                                        isSingleItem: widget.isSingleItem)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PayManager extends StatelessWidget {
  const PayManager({
    super.key,
    required this.isSingleItem,
  });

  final bool isSingleItem;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, address, child) {
        return Consumer<PlaceProvider>(
          builder: (context, orderPlace, child) {
            return Consumer<TableProvider>(
              builder: (context, userTable, child) {
                return MainButtonWidget(
                  buttonPropus: "payment".localeValue(context: context),
                  onPressed: () {
                    if (orderPlace.isTakeaway) {
                      address.chickStatement(
                        context: context,
                        isSingleItem: isSingleItem,
                      );
                      return;
                    }
                    if (userTable.hasTable) {
                      pushTo(PaymentCardScreen(isSingleItem: isSingleItem));

                      return;
                    }
                    showToastification(
                      message: "enter_your_table_toast"
                          .localeValue(context: context),
                      type: ToastificationType.error,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class PaymentsMethods extends StatefulWidget {
  const PaymentsMethods({super.key});

  @override
  State<PaymentsMethods> createState() => _PaymentsMethodsState();
}

class _PaymentsMethodsState extends State<PaymentsMethods> {
  int currentPayment = 1;

  void _selectMethod(int index) {
    setState(() => currentPayment = index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.screenHeight * .15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: paymentCard.length,
        itemBuilder: (context, index) {
          final bool isSelected = index == currentPayment;
          return Clicker(
            onClick: () => _selectMethod(index),
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    SizedBox.square(
                      dimension: context.screenHeight * .12,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: borderRaduis(10),
                          border: isSelected
                              ? Border.all(color: Colors.orange, width: 2)
                              : null,
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: borderRaduis(10),
                          child: Image.asset(
                            paymentCard[index],
                            fit: index == 3 ? BoxFit.fill : BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    if (isSelected)
                      Container(
                        height: 4,
                        width: context.screenWidth * .2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: borderRaduis(6.0),
                        ),
                      ),
                  ],
                ),
                if (isSelected)
                  Positioned(
                    top: 0,
                    right: 7,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.done_outline,
                        color: Colors.white60,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
