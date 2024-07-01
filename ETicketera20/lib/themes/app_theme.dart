import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Color primario
    primaryColor: Colors.indigo,
    // AppBar theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 10,
    ),
    scaffoldBackgroundColor: const Color(0Xff303030),
    // Floating action buttons theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 5,
    ),
  );

  static final ThemeData dayTheme = ThemeData.light().copyWith(
    // Color primario
    primaryColor: const Color.fromRGBO(254, 228, 197, 1),
    // AppBar theme
    appBarTheme: const AppBarTheme(
      color: Color.fromRGBO(254, 228, 197, 1), // Beige
      elevation: 10,
      iconTheme: IconThemeData(color: Color.fromRGBO(210, 105, 30, 1)), // Chocolate
      titleTextStyle: TextStyle(color: Color(0xFFD2691E), fontSize: 20),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(254, 248, 221, 1), // Cornsilk
    // Icon theme
    iconTheme: const IconThemeData(color: Color(0xFFD2691E)),
  );
}
