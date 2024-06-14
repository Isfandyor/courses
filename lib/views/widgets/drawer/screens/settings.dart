import 'package:flutter/material.dart';
import 'package:practice_home/main.dart';
import 'package:practice_home/theme/theme.dart';
import 'package:practice_home/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<ThemeProvider>(context).themeData == darkMode;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.darkmode),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: const TextStyle(fontSize: 16),
                ),
                PopupMenuButton(
                  itemBuilder: (ctx) {
                    return [
                      const PopupMenuItem(value: 0, child: Text("Uzbek")),
                      const PopupMenuItem(value: 1, child: Text("Russion")),
                      const PopupMenuItem(value: 2, child: Text("English")),
                    ];
                  },
                  onSelected: (value) {
                    Provider.of<ChangeLangauge>(context, listen: false)
                        .selectedLangauge(value);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
