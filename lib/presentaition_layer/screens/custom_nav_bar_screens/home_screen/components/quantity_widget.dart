import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    required this.item,
  });

  final FoodModel item;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartManager>(
      builder: (context, getQuantity, child) {
        return Column(
          children: <Widget>[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Quantity",
                    style: TextStyle(
                      fontFamily: FontFamily.mainFont,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: borderRaduis(10),
                      color: SwitchColors.quantityButtonColor,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                if (widget.item.foodType == "Sushi") {
                                  if (widget.item.stock == 5) {
                                    ReusableMethods.showtoastification(
                                      message: "stock_sushi".localeValue(
                                        context: context,
                                      ),
                                    );
                                  } else {
                                    widget.item.stock--;
                                  }
                                } else {
                                  if (widget.item.stock == 1) {
                                    ReusableMethods.showtoastification(
                                      message: "stock_item".localeValue(
                                        context: context,
                                      ),
                                    );
                                  } else {
                                    widget.item.stock--;
                                  }
                                }
                              },
                            );
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.remove,
                              size: 30,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: borderRaduis(7),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            widget.item.stock.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                widget.item.stock++;
                              },
                            );
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.green,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
