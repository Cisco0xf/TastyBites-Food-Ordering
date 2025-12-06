import 'package:flutter/material.dart';
import 'package:foodapp/statemanagement/localization/language_of_app.dart';
import 'package:foodapp/constants/fonts.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({
    super.key,
    required this.detail,
    required this.price,
    this.color = const Color(0xFF757575),
  });

  final String detail;
  final String price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            detail,
            style: TextStyle(
              fontSize: 17,
              fontFamily: context.isEnglish
                  ? FontFamily.mainFont
                  : FontFamily.mainArabic,
              color: color,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 17,
              fontFamily: FontFamily.mainFont,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
