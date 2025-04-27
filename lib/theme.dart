import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff3B3B3B),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff3B3B3B),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF252525),
  ),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green, // Updated primary color
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green, // Updated appBar color
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.green, // Updated FAB color
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.orangeAccent, // Updated secondary color
  ),
  // Add other theme properties as needed
);
