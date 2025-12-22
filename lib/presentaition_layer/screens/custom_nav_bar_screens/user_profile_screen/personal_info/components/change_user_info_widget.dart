import 'package:flutter/material.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/fonts.dart';

class ChangeUserMeta extends StatefulWidget {
  const ChangeUserMeta({
    super.key,
    required this.feildTilte,
    required this.controller,
    this.maxLines = 1,
    this.maxLength,
  });

  final TextEditingController controller;

  final String feildTilte;
  final int? maxLength;
  final int maxLines;

  @override
  State<ChangeUserMeta> createState() => _ChangeUserMetaState();
}

class _ChangeUserMetaState extends State<ChangeUserMeta> {
  bool isEnabled = false;

  void _switchEnable() {
    setState(() => isEnabled = !isEnabled);
  }

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
                widget.feildTilte,
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
                controller: widget.controller,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: FontFamily.mainFont,
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).requestFocus(
                    FocusNode(),
                  );
                },
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                /* validator: validator, */
                decoration: InputDecoration(
                  filled: true,
                  enabled: isEnabled,
                  fillColor: SwitchColor.fillColor,
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
              onPressed: () => _switchEnable(),
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
