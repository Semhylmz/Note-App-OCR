import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/color_constants.dart';

ThemeData lightTheme = ThemeData(
    iconTheme: IconThemeData(color: mBlackOpacityColor),
    appBarTheme: const AppBarTheme(
      color: mWhiteColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: mWhiteColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: mWhiteColor,
          systemNavigationBarIconBrightness: Brightness.dark),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.black,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black.withOpacity(0.1)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: mWhiteColor,
    ),
    scaffoldBackgroundColor: mWhiteColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: mOrange,
    ),
    brightness: Brightness.light);

ThemeData darkTheme = ThemeData(
    iconTheme: IconThemeData(color: mWhiteOpacityColor),
    appBarTheme: const AppBarTheme(
      color: mBlackColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: mBlackColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: mBlackColor,
          systemNavigationBarIconBrightness: Brightness.light),
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.white,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white.withOpacity(0.1),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: mBlackColor,
    ),
    scaffoldBackgroundColor: mBlackColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: mOrange,
    ),
    brightness: Brightness.dark);
