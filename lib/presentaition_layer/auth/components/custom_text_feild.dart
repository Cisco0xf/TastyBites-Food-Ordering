import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/constants/fonts.dart';

typedef SignUpValidator = String? Function(String?)?;

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.textFeildTitle,
    required this.textInputType,
    required this.hintText,
    //required this.validator,
    /* this.suffixIcon = const SizedBox(), */
    this.hasObscure = false,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  //final SignUpValidator validator;
  final String textFeildTitle;
  /* final Widget suffixIcon; */
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
              suffixIcon: suffixIcon(),
            ),
          ),
        ),
      ],
    );
  }
}
