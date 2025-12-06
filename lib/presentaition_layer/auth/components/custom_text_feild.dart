import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';

typedef SignUpValidator = String? Function(String?)?;

class CustomTextFeildWidget extends StatefulWidget {
  const CustomTextFeildWidget({
    super.key,
    required this.controller,
    required this.textFeildTitle,
    required this.textInputType,
    required this.hintText,
    required this.validator,
    this.suffixIcon = const SizedBox(),
    this.isObscure = false,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final SignUpValidator validator;
  final String textFeildTitle;
  final Widget suffixIcon;
  final String hintText;
  final bool isObscure;

  @override
  State<CustomTextFeildWidget> createState() => _CustomTextFeildWidgetState();
}

class _CustomTextFeildWidgetState extends State<CustomTextFeildWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: context.screenWidth * .03,
            ),
            Text(
              widget.textFeildTitle,
              style: const TextStyle(
                fontFamily: FontFamily.mainFont,
                fontSize: 17,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: context.screenWidth * .95,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            textInputAction: TextInputAction.next,
            obscureText: widget.isObscure,
            validator: widget.validator,
            onTapOutside: (event) {
              FocusScope.of(context).requestFocus(
                FocusNode(),
              );
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFeceff1),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRaduis(15),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: borderRaduis(15),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRaduis(15),
                borderSide: const BorderSide(
                  color: Colors.orange,
                  width: 1,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontFamily: FontFamily.mainFont,
                fontWeight: FontWeight.w300,
              ),
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
