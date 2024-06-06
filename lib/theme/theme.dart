import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(),
  colorScheme: ColorScheme.light(
    surface: Colors.green.shade400,
    primary: Colors.green.shade300,
    secondary: Colors.green.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
);
