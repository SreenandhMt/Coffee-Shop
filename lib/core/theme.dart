import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(primary: Color.fromRGBO(2, 170, 100, 1),secondary: Colors.grey)
  );

  static final lightTheme = ThemeData.light().copyWith(
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.rubik(color: Colors.black)
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 242, 242, 242),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      foregroundColor: Colors.black,
      elevation: 0
    ),
    colorScheme: const ColorScheme.light().copyWith(primary: Color.fromRGBO(2, 170, 100, 1),secondary: Colors.grey)
  );
}