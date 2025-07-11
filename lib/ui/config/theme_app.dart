import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

//Tema Light
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
      ),
      backgroundColor: WidgetStateProperty.all(secondaryColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      textStyle: WidgetStateProperty.all(
        const TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  ),
  progressIndicatorTheme:
  const ProgressIndicatorThemeData(color: secondaryColor),
  dividerTheme: DividerThemeData(color: Colors.grey.shade400),
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade400,
    primary: Colors.grey.shade300,
    secondary: secondaryColor,
    tertiary: Colors.grey.shade100,
  ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    centerTitle: true,
    elevation: 0,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: secondaryColor, fontSize: 18),
    isDense: true,
    contentPadding: EdgeInsets.zero,
    labelStyle: TextStyle(fontSize: 18),
    focusColor: secondaryColor,
    border: InputBorder.none,
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide()),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: secondaryColor),
    ),
    errorBorder:
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    errorStyle: TextStyle(color: Colors.red),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 17),
    bodyLarge: TextStyle(fontSize: 18),
    displaySmall: TextStyle(fontSize: 16),
    displayMedium: TextStyle(fontSize: 17),
    displayLarge: TextStyle(fontSize: 18),
    labelSmall: TextStyle(fontSize: 16),
    labelMedium: TextStyle(fontSize: 17),
    labelLarge: TextStyle(fontSize: 18),
    headlineSmall: TextStyle(fontSize: 16),
    headlineMedium: TextStyle(fontSize: 17),
    headlineLarge: TextStyle(fontSize: 18),
  ),
);

//Tema Dark
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
      ),
      backgroundColor: WidgetStateProperty.all(secondaryColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 20),
      ),
    ),
  ),
  progressIndicatorTheme:
  const ProgressIndicatorThemeData(color: secondaryColor),
  dividerTheme: DividerThemeData(color: Colors.grey.shade800),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade100,
    tertiary: Colors.grey.shade500,
  ),
  appBarTheme: const AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      centerTitle: true,
      elevation: 0),
  inputDecorationTheme: const InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: secondaryColor, fontSize: 18),
    isDense: true,
    labelStyle: TextStyle(
      fontSize: 18,
    ),
    focusColor: secondaryColor,
    border: InputBorder.none,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: secondaryColor),
    ),
    errorBorder:
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    errorStyle: TextStyle(color: Colors.red),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(fontSize: 14),
    bodyMedium: TextStyle(fontSize: 15),
    bodyLarge: TextStyle(fontSize: 16),
    displaySmall: TextStyle(fontSize: 14),
    displayMedium: TextStyle(fontSize: 15),
    displayLarge: TextStyle(fontSize: 16),
    labelSmall: TextStyle(fontSize: 14),
    labelMedium: TextStyle(fontSize: 15),
    labelLarge: TextStyle(fontSize: 16),
  ),
);

const Color primaryColor = Color(0xFF002A4D);
const Color secondaryColor = Color(0xFFB4520C);
const Color thirdColor = Color(0xFF021B30);
