import 'package:flutter/material.dart';
import 'package:practice_home/theme/theme.dart';
import 'package:practice_home/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<ThemeProvider>(context).themeData == darkMode;

    return Scaffold(
      appBar: AppBar(),
      body: SwitchListTile(
        title: const Text("Dark mode"),
        value: isDarkMode,
        onChanged: (value) {
          final themeProvider =
              Provider.of<ThemeProvider>(context, listen: false);
          if (value) {
            themeProvider.setTheme(darkMode);
          } else {
            themeProvider.setTheme(lightMode);
          }
        },
      ),
    );
  }
}
