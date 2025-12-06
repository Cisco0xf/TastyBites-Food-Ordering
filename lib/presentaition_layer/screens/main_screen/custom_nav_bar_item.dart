import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';

class CustomNavigationBarItem extends StatefulWidget {
  const CustomNavigationBarItem({
    super.key,
    required this.onPressed,
    required this.selectedColor,
    required this.icon,
  });

  final void Function() onPressed;
  final Color? selectedColor;
  final Icon icon;

  @override
  State<CustomNavigationBarItem> createState() =>
      _CustomNavigationBarItemState();
}

class _CustomNavigationBarItemState extends State<CustomNavigationBarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: context.screenWidth * .17,
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: borderRaduis(20),
          color: widget.selectedColor,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
