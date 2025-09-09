import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static InputDecorationTheme theme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.primaryColor,
    hintStyle: TextStyle(
      color: AppColors.textSecondary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 1), width: 1),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 1), width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 1), width: 1),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 1), width: 1),
    ),
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 13,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter-Regular',
    ),
  );
}
