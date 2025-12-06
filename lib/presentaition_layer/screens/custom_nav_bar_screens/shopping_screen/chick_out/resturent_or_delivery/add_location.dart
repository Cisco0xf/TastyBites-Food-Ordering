import 'package:flutter/material.dart';
import 'package:foodapp/constants/input_decoration.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/statemanagement/user_address/get_user_address.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class AddLocaltionWidget extends StatelessWidget {
  const AddLocaltionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, address, __) {
        return Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              width: context.screenWidth * .97,
              height: context.screenHeight * .07,
              child: TextField(
                controller: address.addressController,
                keyboardType: TextInputType.text,
                autofocus: true,
                scrollPadding: const EdgeInsets.only(top: 10),
                decoration: textFeildDecpration(context: context),
              ),
            ),
            if (address.error.isNotEmpty) ...{
              Text(
                address.error,
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: context.isEnglish ? null : FontFamily.mainArabic,
                ),
              )
            }
          ],
        );
      },
    );
  }
}
