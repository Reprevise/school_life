import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  accentColor: Colors.grey[600],
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textSelectionHandleColor: Colors.black,
  textSelectionColor: Colors.black12,
  cursorColor: Colors.black,
  dividerColor: Colors.black,
  primaryIconTheme: const IconThemeData(color: Colors.black),
  buttonColor: Colors.grey[600],
  inputDecorationTheme: InputDecorationTheme(
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusColor: Colors.black,
    labelStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: .5,
      fontFamily: 'Arial',
      fontSize: 16.0,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[600]),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
  ),
  dialogTheme: const DialogTheme(
    elevation: 1,
    contentTextStyle: TextStyle(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 2.0,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.black,
    textTheme: ButtonTextTheme.accent,
  ),
  accentTextTheme: TextTheme(
    bodyText2: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey[600],
    ),
  ),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.rubik(
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    bodyText2: GoogleFonts.muli(
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    button: GoogleFonts.openSans(
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(color: Colors.black),
    ),
    headline4: GoogleFonts.muli(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        letterSpacing: 0.3,
        color: Colors.black,
      ),
    ),
    headline3: GoogleFonts.muli(
      fontSize: 21.0,
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    headline2: GoogleFonts.muli(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    headline1: GoogleFonts.muli(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  accentColor: Colors.grey[300],
  scaffoldBackgroundColor: Colors.grey[900],
  backgroundColor: Colors.grey[900],
  textSelectionHandleColor: Colors.white,
  textSelectionColor: Colors.white12,
  cursorColor: Colors.white,
  dividerColor: Colors.white,
  primaryIconTheme: const IconThemeData(color: Colors.white),
  buttonColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusColor: Colors.white,
    labelStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: .5,
      fontFamily: 'Arial',
      fontSize: 16.0,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[300]),
    ),
  ),
  dialogTheme: const DialogTheme(
    elevation: 0,
    contentTextStyle: TextStyle(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 2.0,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.white,
    textTheme: ButtonTextTheme.accent,
  ),
  applyElevationOverlayColor: true,
  accentTextTheme: TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey[300],
    ),
  ),
  textTheme: TextTheme(
    bodyText2: GoogleFonts.rubik(
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    bodyText1: GoogleFonts.muli(
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    button: GoogleFonts.openSans(
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(color: Colors.black),
    ),
    headline4: GoogleFonts.muli(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        letterSpacing: 0.3,
        color: Colors.black,
      ),
    ),
    headline3: GoogleFonts.muli(
      fontSize: 21.0,
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    headline2: GoogleFonts.muli(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    headline1: GoogleFonts.muli(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);
