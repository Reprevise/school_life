import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final textTheme = TextTheme(
  headline1: GoogleFonts.raleway(
    fontSize: 98,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.raleway(
    fontSize: 61,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.raleway(
    fontSize: 49,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.raleway(
    fontSize: 35,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.raleway(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.raleway(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.raleway(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.raleway(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  accentColor: const Color(0xFF494949),
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  dividerColor: Colors.black,
  disabledColor: Colors.grey[600],
  primaryIconTheme: const IconThemeData(color: Colors.black),
  buttonColor: Colors.grey[600],
  bottomAppBarColor: Color(0xFFededed),
  unselectedWidgetColor: Colors.grey,
  inputDecorationTheme: InputDecorationTheme(
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusColor: Colors.black,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade600),
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
  buttonTheme: const ButtonThemeData(buttonColor: Colors.black),
  textTheme: textTheme,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  accentColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey[900],
  disabledColor: Colors.black,
  backgroundColor: Colors.grey[900],
  dividerColor: Colors.white,
  primaryIconTheme: const IconThemeData(color: Colors.white),
  buttonColor: Colors.white,
  bottomAppBarColor: Color(0xFF1c1c1c),
  unselectedWidgetColor: Colors.grey,
  inputDecorationTheme: InputDecorationTheme(
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusColor: Colors.white,
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
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
  buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
  applyElevationOverlayColor: true,
  textTheme: textTheme,
);
