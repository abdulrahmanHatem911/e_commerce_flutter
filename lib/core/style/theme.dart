import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.ubuntu(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.ubuntu(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black45,
    ),
    headline2: GoogleFonts.ubuntu(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.ubuntu(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline4: GoogleFonts.ubuntu(
      fontSize: 14.0,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    headline5: GoogleFonts.ubuntu(
      fontSize: 16.0,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    headline6: GoogleFonts.ubuntu(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.ubuntu(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.ubuntu(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.ubuntu(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.ubuntu(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline4: GoogleFonts.ubuntu(
      fontSize: 14.0,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    headline5: GoogleFonts.ubuntu(
      fontSize: 16.0,
      color: Colors.black45,
      fontWeight: FontWeight.w600,
    ),
    headline6: GoogleFonts.ubuntu(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'Ubuntu',
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.black;
          },
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.primerColor,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}
