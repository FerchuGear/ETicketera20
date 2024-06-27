import 'package:flutter/material.dart';

class AppTheme{
  static const Color primary = Colors.indigo;

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
        
        //color primario
        primaryColor: Colors.indigo,
        //appbar theme
        appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 10
        ),
        scaffoldBackgroundColor: const Color(0Xff303030),
        //text buttons theme
        
        // textButtonTheme: TextButtonThemeData(
        //   style: TextButton.styleFrom(foregroundColor: primary, textStyle: const TextStyle( fontFamily: 'Techno'))
        // ),
        
        //floating action buttons theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          elevation: 5
        ),
        //elevated buttons theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 0,
          ),
        ),
        //
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: primary),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
        ),
  );
}