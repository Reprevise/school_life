import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    // accentColor: Colors.white,
    accentColor: Colors.grey[600],
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textSelectionHandleColor: Colors.black,
    textSelectionColor: Colors.black12,
    cursorColor: Colors.black,
    dividerColor: Colors.black,
    primaryIconTheme: IconThemeData(color: Colors.black),
    buttonColor: Colors.grey[600],
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusColor: Colors.black,
      filled: true,
      fillColor: Colors.grey[500],
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: .5,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[600]),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    dialogTheme: DialogTheme(
      elevation: 1,
      contentTextStyle: TextStyle(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[800],
      foregroundColor: Colors.white,
      elevation: 2.0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.accent,
    ),
    applyElevationOverlayColor: false,
    textTheme: TextTheme(
      body1: TextStyle(color: Colors.black),
      button: TextStyle(color: Colors.black),
      display1: TextStyle(
        fontSize: 15.0,
        fontFamily: "Muli",
        letterSpacing: .3,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      display2: TextStyle(
        fontSize: 21.0,
        fontFamily: "Muli",
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      display3: TextStyle(
        fontSize: 24.0,
        fontFamily: "Muli",
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    // accentColor: Colors.grey[900],
    accentColor: Colors.grey[300],
    scaffoldBackgroundColor: Colors.grey[900],
    backgroundColor: Colors.grey[900],
    textSelectionHandleColor: Colors.white,
    textSelectionColor: Colors.white12,
    cursorColor: Colors.white,
    dividerColor: Colors.white,
    primaryIconTheme: IconThemeData(color: Colors.white),
    buttonColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusColor: Colors.white,
      filled: true,
      fillColor: Colors.grey[800],
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: .5,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300]),
      ),
    ),
    dialogTheme: DialogTheme(
      elevation: 0,
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 2.0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.accent,
    ),
    applyElevationOverlayColor: false,
    textTheme: TextTheme(
      body1: TextStyle(color: Colors.white),
      button: TextStyle(color: Colors.black),
      display1: TextStyle(
        fontSize: 15.0,
        fontFamily: "Muli",
        letterSpacing: .3,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      display2: TextStyle(
        fontSize: 21.0,
        fontFamily: "Muli",
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      display3: TextStyle(
        fontSize: 24.0,
        fontFamily: "Muli",
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );

}
