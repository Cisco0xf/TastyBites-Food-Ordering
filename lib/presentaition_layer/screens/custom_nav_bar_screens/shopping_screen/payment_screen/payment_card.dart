import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/constants/input_decoration.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/order_single_item/order_single_item_provider.dart';
import 'package:foodapp/statemanagement/reuable_methods/reusable_methods.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_model.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_history_provider.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/payment_screen/success_payment.dart';
import 'package:foodapp/presentaition_layer/widgets/main_button.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class PaymentCardScreen extends StatefulWidget {
  const PaymentCardScreen({
    super.key,
    required this.isSingleItem,
  });
  final bool isSingleItem;

  @override
  State<PaymentCardScreen> createState() => _PaymentCardScreenState();
}

class _PaymentCardScreenState extends State<PaymentCardScreen> {
  String cardNumber = "";
  String expiryDate = "";
  String cardHolderName = "";
  String cvvCode = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale("en"),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: SwitchColors.backgroundMianColor,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: context.screenHeight * .06,
              ),
              width: double.infinity,
              height: context.screenHeight * .1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 35,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: context.screenWidth * .12,
                    ),
                    const Text(
                      "Payment process",
                      style: TextStyle(
                        fontFamily: FontFamily.mainFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: context.screenHeight * .01,
            ),
            const Gap(hRatio: 0.01),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              isHolderNameVisible: true,
              cardBgColor: const Color(0xFF1b5e20),
              showBackView: false,
              onCreditCardWidgetChange: (cardData) {},
              isSwipeGestureEnabled: true,
              frontCardBorder: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              backCardBorder: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.discover,
                  cardImage: Image.asset(
                    "asstes/images/app_images/payment_images/meeza.png",
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: (cardData) {
                    setState(() {
                      cardNumber = cardData.cardNumber;
                      expiryDate = cardData.expiryDate;
                      cardHolderName = cardData.cardHolderName;
                      cvvCode = cardData.cvvCode;
                    });
                  },
                  cvvValidationMessage: "Please enter cvv",
                  numberValidationMessage: "Not valid number",
                  dateValidationMessage: "Please enter the date",
                  formKey: formKey,
                  inputConfiguration: InputConfiguration(
                    cardNumberDecoration: creditCardinputDecoration(
                      lableText: "Number",
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: creditCardinputDecoration(
                      lableText: "Expired Date",
                      hintText: 'XX/XX',
                    ),
                    cardHolderDecoration: creditCardinputDecoration(
                      lableText: "Card Holder(Optional)",
                      hintText: 'Name on the card',
                    ),
                    cvvCodeDecoration: creditCardinputDecoration(
                      lableText: "CVV",
                      hintText: "XXX",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
            left: 10,
            right: 10,
          ),
          child: MainButtonWidget(
            buttonPropus: "confirm_payment".localeValue(context: context),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: context.screenWidth,
                      child: Consumer<CartManager>(
                        builder: (context, shoppingCart, child) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.all(0),
                            title: Text(
                              "confirmation".localeValue(context: context),
                              style: TextStyle(
                                fontSize: context.isEnglish ? 20 : 22,
                                fontFamily: context.isEnglish
                                    ? null
                                    : FontFamily.mainArabic,
                              ),
                            ),
                            content: SizedBox(
                              width: double.infinity,
                              height: context.screenHeight * .16,
                              child: Column(
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Card Number : $cardNumber"),
                                  if (cardHolderName.isNotEmpty)
                                    Text("Card Holder : $cardHolderName"),
                                  Text("Card expiry date : $expiryDate"),
                                  Text("Card CVV code : $cvvCode"),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: padding(5),
                                    decoration: BoxDecoration(
                                      borderRadius: borderRaduis(7),
                                      color: Colors.white54,
                                    ),
                                    child: Consumer<SingleItemProvider>(
                                      builder: (context, singleItem, child) {
                                        return Text(
                                          widget.isSingleItem
                                              ? "Total Single Price : \$ ${singleItem.getTotalPriceAfterDiscountAndService()}"
                                              : "Total Price : \$ ${shoppingCart.getOrderTotalArterDiscountAndService()}",
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "cancle".localeValue(context: context),
                                  style: TextStyle(
                                    fontFamily: context.isEnglish
                                        ? null
                                        : FontFamily.mainArabic,
                                    fontSize: context.isEnglish ? null : 16,
                                  ),
                                ),
                              ),
                              Consumer<ManageReceiptHistory>(
                                builder: (context, saveReceipt, _) {
                                  return MaterialButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      /*  Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SuccessfulPaymentWidget(
                                              isSingleItem: widget.isSingleItem,
                                            );
                                          },
                                        ),
                                      ).whenComplete(() async {
                                        
                                      }); */
                                      /* saveReceipt.addNewReceipt(
                                        context: context,
                                        receipt: !widget.isSingleItem
                                            ? ReceiptHistoryModel(
                                                newReceipt:
                                                    cartReceipt.getRecepit(
                                                        context: context,
                                                        isHistory: true),
                                                dateTime: cartReceipt.dateTime,
                                              )
                                            : ReceiptHistoryModel(
                                                newReceipt: singleItemReceipt
                                                    .singleOrderReceipt(
                                                        context: context),
                                                dateTime: singleItemReceipt
                                                    .getDateTime),
                                      ); */
                                      pushTo(
                                        SuccessfulPaymentWidget(
                                          isSingleItem: widget.isSingleItem,
                                        ),
                                        type: Push.replace,
                                      );
                                      await saveReceipt.addNewReceipt(
                                          isSingle: widget.isSingleItem);
                                    },
                                    color: Colors.orange,
                                    child: Text(
                                      "confim".localeValue(context: context),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: context.isEnglish
                                            ? null
                                            : FontFamily.mainArabic,
                                        fontSize: context.isEnglish ? null : 16,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              } else {
                ReusableMethods.showtoastification(
                  message: "Please enter the correct information",
                  type: ToastificationType.error,
                  progressBarColor: Colors.red,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
