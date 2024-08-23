import 'package:flutter/material.dart';

class AppStyle{
  static  Color lightPrimaryColor= Color(0xff3396D8);
  static const Color bgColor=Color(0xffddead9);
  static ThemeData lightTheme=ThemeData(
      floatingActionButtonTheme:  FloatingActionButtonThemeData(
      iconSize: 25,
      backgroundColor: lightPrimaryColor,
      shape: const StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 4
        )
      )
    ),
    scaffoldBackgroundColor: bgColor,
    appBarTheme:  AppBarTheme(
      toolbarHeight: 200,
      backgroundColor: lightPrimaryColor,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 40
      )
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: lightPrimaryColor,
    primary: lightPrimaryColor),
    useMaterial3: false
  );
}