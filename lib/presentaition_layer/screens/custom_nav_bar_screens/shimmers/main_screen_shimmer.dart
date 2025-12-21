import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/enums.dart';
import 'package:foodapp/statemanagement/add_to_cart/add_to_cart_provider.dart';
import 'package:foodapp/statemanagement/cloud_firestore/manage_metadata.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:foodapp/statemanagement/receipt_management/receipt_history_provider.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/presentaition_layer/screens/main_screen/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainScreenShimmer extends StatefulWidget {
  const MainScreenShimmer({super.key});

  @override
  State<MainScreenShimmer> createState() => _MainScreenShimmerState();
}

class _MainScreenShimmerState extends State<MainScreenShimmer> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (mounted) {
          await context.read<CartManager>().initializeCart();
        }

        if (mounted) {
          await context.read<WishListProvider>().initializeWishList();
        }

        if (mounted) {
          await context.read<ManageReceiptHistory>().initializeReceipts();
        }

        await ManageUserMetadata().setBio();

        pushTo(const MainScreen(), type: Push.replace);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Shimmer.fromColors(
            baseColor:
                context.isLight ? Colors.grey.shade300 : Colors.grey.shade800,
            highlightColor:
                context.isLight ? Colors.grey.shade100 : Colors.grey.shade700,
            child: Column(
              children: <Widget>[
                const Gap(hRatio: .07),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: context.screenHeight * .03,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 30,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRaduis(10),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRaduis(10),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRaduis(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: context.screenWidth * .5,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: borderRaduis(10),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                color: context.isLight
                    ? const Color(0xFFf5f5f5)
                    : const Color(0xFF181818),
              ),
              child: Shimmer.fromColors(
                baseColor: context.isLight
                    ? Colors.grey.shade300
                    : Colors.grey.shade800,
                highlightColor: context.isLight
                    ? Colors.grey.shade100
                    : Colors.grey.shade700,
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: context.screenWidth * .7,
                              height: context.screenHeight * .06,
                              decoration: BoxDecoration(
                                borderRadius: borderRaduis(25),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: context.screenWidth * .2,
                              height: context.screenHeight * .06,
                              decoration: BoxDecoration(
                                borderRadius: borderRaduis(25),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(10),
                            width: context.screenWidth * .4,
                            height: context.screenHeight * .02,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: borderRaduis(10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: context.screenHeight * .07,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemExtent: context.screenWidth * .45,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              height: context.screenHeight * .07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRaduis(20),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: context.screenHeight * .467,
                            crossAxisSpacing: 17,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              height: context.screenHeight * .447,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRaduis(20),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
