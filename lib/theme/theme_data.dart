import 'package:flutter/material.dart';

ThemeData lightTheme=ThemeData.light().copyWith(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Color(0xFF161619),
    ),
    titleMedium: TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.w700,
      color: Color(0xFF161619),
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color(0xFF161619),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161619),
    ),
  )
);
Color primaryColor=Color(0xffEE6855);

Color secondaryTextColor=Color(0xFFAEB6CE);