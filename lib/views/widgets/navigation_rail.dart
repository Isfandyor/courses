import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_home/providers/index_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyNavigationRail extends StatelessWidget {
  const MyNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          onDestinationSelected:
              Provider.of<IndexProvider>(context).selectedIndex,
          labelType: NavigationRailLabelType.selected,
          destinations: <NavigationRailDestination>[
            NavigationRailDestination(
              icon: const Icon(Icons.home),
              label: Text(AppLocalizations.of(context)!.home),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.favorite),
              label: Text(AppLocalizations.of(context)!.favorites),
            ),
            NavigationRailDestination(
              icon: const Icon(CupertinoIcons.cart),
              label: Text(AppLocalizations.of(context)!.cart),
            ),
            NavigationRailDestination(
              icon: const Icon(
                Icons.note_alt_outlined,
              ),
              label: Text(AppLocalizations.of(context)!.notes),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.person),
              label: Text(AppLocalizations.of(context)!.profile),
            ),
          ],
          selectedIndex: Provider.of<IndexProvider>(context).currentIndex,
        ),
      ],
    );
  }
}
