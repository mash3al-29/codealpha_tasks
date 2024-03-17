import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_styles.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      // colorScheme: const ColorScheme(
      //     brightness: Brightness.light,
      //     primary: ,
      //     onPrimary: Colors.white,
      //     secondary: Colors.black,
      //     onSecondary: Colors.white,
      //     error: Colors.red,
      //     onError: Colors.black,
      //     background: Colors.white,
      //     onBackground: Colors.black,
      //     surface: ,
      //     onSurface: Colors.black),
      primaryColor: Colors.lightBlue,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.lightBlue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        centerTitle: true,
        titleTextStyle: titleText,
        toolbarHeight: 70.h
      )
  );
}