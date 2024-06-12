import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(),
  colorScheme: ColorScheme.light(
    surface: Colors.blue.shade900,
    primary: Colors.blue.shade400,
    secondary: Colors.blue.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.blue.shade800,
    secondary: Colors.grey.shade700,
  ),
);
