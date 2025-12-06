import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/fonts.dart';

typedef UpdateUserInfo = void Function(String?)?;
typedef FocuseUnFocuseFeild = void Function()?;
typedef UpdateUserInfoValidator = String? Function(String?)?;

class ChangeUserInfoWidget extends StatelessWidget {
  const ChangeUserInfoWidget({
    super.key,
    required this.feildTilte,
    required this.unFocuseFeild,
    required this.onChange,
    required this.controller,
    required this.unFocuse,
    required this.validator,
    this.maxLines = 1,
    this.maxLength,
  });

  final UpdateUserInfoValidator validator;
  final TextEditingController controller;
  final FocuseUnFocuseFeild unFocuse;
  final UpdateUserInfo onChange;
  final bool unFocuseFeild;
  final String feildTilte;
  final int? maxLength;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
            left: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                feildTilte,
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: FontFamily.mainFont,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              width: context.screenWidth * .8,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: FontFamily.mainFont,
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).requestFocus(
                    FocusNode(),
                  );
                },
                maxLines: maxLines,
                maxLength: maxLength,
                validator: validator,
                decoration: InputDecoration(
                  filled: true,
                  enabled: unFocuseFeild,
                  fillColor: const Color(0xFFeceff1),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRaduis(15),
                    borderSide: const BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRaduis(15),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: borderRaduis(15),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: borderRaduis(15),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  hintText: "Change your username",
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    fontFamily: FontFamily.mainFont,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: unFocuse,
              icon: const Icon(
                Icons.edit,
                size: 25,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
