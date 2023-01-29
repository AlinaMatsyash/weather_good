import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_good/theme/color.dart';

class ProjectTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.44,
      color: ColorPalette.grey_300,
    ),
    overline: GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      height: 1.6,
      letterSpacing: 1.5,
      color: ColorPalette.green,
    ),
    headline4: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 34,
      height: 1.17,
      letterSpacing: 0.25,
      color: ColorPalette.black,
    ),
    headline6: GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.4,
      letterSpacing: 0.15,
      color: ColorPalette.black,
    ),
    caption: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      height: 1.3,
      letterSpacing: 0.5,
      color: ColorPalette.grey_250,
    ),
    subtitle1: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      letterSpacing: 0.15,
      height: 1.5,
      color: ColorPalette.black,
    ),
    subtitle2: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: 0.1,
      height: 1.4,
      color: ColorPalette.black,
    ),
    bodyText2: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
      color: ColorPalette.black,
    ),
    //W700
    headline1: GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      height: 1.3,
      color: ColorPalette.black,
    ),
    //body_1
    headline2: GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.5,
      color: ColorPalette.black,
    ),
    //headline7
    headline3: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 13,
      height: 1.5,
      letterSpacing: 0.5,
      color: ColorPalette.black,
    ),
    button: GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.7,
      letterSpacing: 1.5,
      color: ColorPalette.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.44,
      color: ColorPalette.grey_300,
    ),
    overline: GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      fontSize: 10,
      height: 1.6,
      letterSpacing: 1.5,
      color: ColorPalette.green,
    ),
    headline4: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 34,
      height: 1.17,
      letterSpacing: 0.25,
      color: ColorPalette.white,
    ),
    headline6: GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.4,
      letterSpacing: 0.15,
      color: ColorPalette.white,
    ),
    caption: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      height: 1.3,
      letterSpacing: 0.5,
      color: ColorPalette.grey_250,
    ),
    subtitle1: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      letterSpacing: 0.15,
      height: 1.5,
      color: ColorPalette.white,
    ),
    subtitle2: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: 0.1,
      height: 1.4,
      color: ColorPalette.white,
    ),
    bodyText2: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
      color: ColorPalette.white,
    ),
    //W700
    headline1: GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      height: 1.3,
      color: ColorPalette.white,
    ),
    //body_1
    headline2: GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.5,
      color: ColorPalette.white,
    ),
    //headline7
    headline3: GoogleFonts.openSans(
      fontWeight: FontWeight.normal,
      fontSize: 13,
      height: 1.5,
      letterSpacing: 0.5,
      color: ColorPalette.white,
    ),
    button: GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.7,
      letterSpacing: 1.5,
      color: ColorPalette.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: ColorPalette.white),
      shadowColor: ColorPalette.black,
      backgroundColor: ColorPalette.white,
      bottomAppBarColor: ColorPalette.white,
      primaryColor: Colors.white,
      accentColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.green,
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: ColorPalette.black_800),
      shadowColor: ColorPalette.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorPalette.black_800,
      ),
      scaffoldBackgroundColor: ColorPalette.black_800,
      backgroundColor: ColorPalette.black_800,
      primaryColor: ColorPalette.black_800,
      accentColor: ColorPalette.green,
      textTheme: darkTextTheme,
    );
  }
}
