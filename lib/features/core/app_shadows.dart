import 'package:flutter/material.dart';

class AppShadows {
  static const List<BoxShadow> primary = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.05),
    ),
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0),
    ),
  ];
}
