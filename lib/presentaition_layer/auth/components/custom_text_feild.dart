import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/fonts.dart';

typedef SignUpValidator = String? Function(String?)?;

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.textFeildTitle,
    required this.textInputType,
    required this.hintText,
    this.hasObscure = false,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final String textFeildTitle;
  final String hintText;
  final bool hasObscure;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = true;

  void _switchObscureState() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  Widget? suffixIcon() {
    if (!widget.hasObscure) {
      return null;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: Clicker(
        onClick: () {
          _switchObscureState();
        },
        child: isObscure
            ? const Icon(
                Icons.visibility,
                key: ValueKey("MIbfj-efien"),
              )
            : const Icon(
                Icons.visibility_off,
                key: ValueKey("Mrgeibgfw"),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Gap(wRatio: 0.03),
            Text(
              widget.textFeildTitle,
              style: const TextStyle(
                fontFamily: FontFamily.mainFont,
                fontSize: 17,
              ),
            ),
          ],
        ),
        const Gap(height: 10.0),
        SizedBox(
          width: context.screenWidth * .95,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            textInputAction: TextInputAction.next,
            obscureText: isObscure && widget.hasObscure,
            // validator: widget.validator,
            onTapOutside: (event) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: SwitchColor.fillColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRaduis(15),
                borderSide: BorderSide(color: SwitchColor.borderColor),
              ),
              border: OutlineInputBorder(
                borderRadius: borderRaduis(15),
                borderSide: BorderSide(color: SwitchColor.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRaduis(15),
                borderSide: const BorderSide(color: Colors.orange),
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontFamily: FontFamily.mainFont,
                fontWeight: FontWeight.w300,
              ),
              suffixIcon: suffixIcon(),
            ),
          ),
        ),
      ],
    );
  }
}
