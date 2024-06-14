import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_home/providers/index_provider.dart';
import 'package:practice_home/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:
          Provider.of<ThemeProvider>(context).themeData.colorScheme.surface,
      currentIndex: Provider.of<IndexProvider>(context).currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor:
          Provider.of<ThemeProvider>(context).themeData.primaryColorDark,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: AppLocalizations.of(context)!.favorites,
        ),
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.cart),
          label: AppLocalizations.of(context)!.cart,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.note_alt_outlined,
          ),
          label: AppLocalizations.of(context)!.notes,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: AppLocalizations.of(context)!.profile,
        ),
      ],
      onTap: Provider.of<IndexProvider>(context).selectedIndex,
    );
  }
}
