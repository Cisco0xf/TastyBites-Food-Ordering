import 'package:flutter/material.dart';

class PopButtonWidget extends StatelessWidget {
  const PopButtonWidget({
    super.key,
    this.buttonColor = Colors.orange,
  });

  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: buttonColor,
          size: 35,
        ),
      ),
    );
  }
}
