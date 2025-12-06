import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/presentaition_layer/screens/custom_nav_bar_screens/shopping_screen/chick_out/resturent_or_delivery/tables_bottom_sheet.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/localization/localization_delegate.dart';
import 'package:foodapp/statemanagement/user_table/get_user_table.dart';
import 'package:foodapp/constants/app_colors.dart';

import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';

import 'package:provider/provider.dart';

class ChoosTableWidget extends StatelessWidget {
  const ChoosTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TableProvider>(
      builder: (context, userTable, child) {
        final String tableLabel = userTable.hasTable
            ? "your_table".localeValue(context: context)
            : "";

        final String? family = context.isEnglish ? null : FontFamily.mainArabic;

        return Container(
          margin: padding(10.0),
          height: context.screenHeight * .07,
          decoration: BoxDecoration(
            borderRadius: borderRaduis(30),
            color: SwitchColors.chickoutFillColor,
          ),
          child: Clicker(
            onClick: () => showTablesSheet(),
            innerPadding: 0.0,
            raduis: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.orange),
                      const Gap(wRatio: 0.04),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: tableLabel,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: family),
                            ),
                            TextSpan(
                              text: userTable.hasTable
                                  ? "  ${userTable.selectedTable}"
                                  : "  ${userTable.selectedTable.localeValue(context: context)}",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: family,
                                fontWeight: FontWeight.bold,
                                color: userTable.hasTable
                                    ? const Color(0xFFFF5B22)
                                    : const Color(0xFFB0A695),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.keyboard_arrow_down_sharp,
                      color: Colors.orange)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
