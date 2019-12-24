import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
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
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
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
    textTheme: TextTheme(
      body1: GoogleFonts.rubik(
        textStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      body2: GoogleFonts.muli(
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      button: GoogleFonts.openSans(
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(color: Colors.black),
      ),
      display1: GoogleFonts.muli(
        fontSize: 15.0,
        fontWeight: FontWeight.w700,
        textStyle: TextStyle(
          letterSpacing: 0.3,
          color: Colors.black,
        ),
      ),
      display2: GoogleFonts.muli(
        fontSize: 21.0,
        fontWeight: FontWeight.w700,
        textStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      display3: GoogleFonts.muli(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
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
    applyElevationOverlayColor: true,
    textTheme: TextTheme(
      body1: GoogleFonts.rubik(
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      body2: GoogleFonts.muli(
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      button: GoogleFonts.openSans(
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(color: Colors.black),
      ),
      display1: GoogleFonts.muli(
        fontSize: 15.0,
        fontWeight: FontWeight.w700,
        textStyle: TextStyle(
          letterSpacing: 0.3,
          color: Colors.black,
        ),
      ),
      display2: GoogleFonts.muli(
        fontSize: 21.0,
        fontWeight: FontWeight.w700,
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      display3: GoogleFonts.muli(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}
