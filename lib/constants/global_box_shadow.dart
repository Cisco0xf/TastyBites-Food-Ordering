import 'package:flutter/material.dart';

List<BoxShadow> globalBoxShadow = <BoxShadow>[
  BoxShadow(
    blurRadius: 5,
    spreadRadius: .1,
    blurStyle: BlurStyle.normal,
    color: Colors.grey.shade400,
    offset: const Offset(4, 4),
  ),
  const BoxShadow(
    blurRadius: 5,
    blurStyle: BlurStyle.normal,
    color: Colors.white,
    spreadRadius: .1,
    offset: Offset(-4, -4),
  )
];
