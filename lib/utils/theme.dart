import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_utils.dart';

class ThemeUtils {
  static ThemeData theme = ThemeData(
    fontFamily: GoogleFonts.lato().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(ColorUtils.primary),
    ),
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      caption: TextStyle(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(ColorUtils.primary),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            color: Color(ColorUtils.primary),
          ),
        ),
      ),
    ),
  );
}
