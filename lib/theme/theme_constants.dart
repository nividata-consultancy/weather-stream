import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  backgroundColor: const Color(0xFFF9F9F9),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFFf2f2f2),
  ),
  cardTheme: const CardTheme(
    color: Color(0xff4765ff),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFF05042e),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFFf2f2f2),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFF05042e),
    ),
    bodyText2: TextStyle(
      color: Color(0xFF37474F),
    ),
    subtitle1: TextStyle(
      color: Color(0xFF616161),
    ),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  backgroundColor: const Color(0xFF111b25),
  cardTheme: const CardTheme(
    color: Color(0xff192533),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFF141F2B),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xff192533),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFFf9fafa),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFFf9fafa),
    ),
    bodyText2: TextStyle(
      color: Color(0xfff9f9f9),
    ),
    subtitle1: TextStyle(
      color: Color(0xFFececec),
    ),
  ),
);
