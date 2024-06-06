import 'package:flutter/material.dart';
import 'package:practice_home/providers/index_provider.dart';
import 'package:provider/provider.dart';

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
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text("Home"),
            ),
            NavigationRailDestination(
              icon: Icon(
                Icons.stacked_line_chart_rounded,
              ),
              label: Text("Results"),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person),
              label: Text("Profile"),
            ),
          ],
          selectedIndex: Provider.of<IndexProvider>(context).currentIndex,
        ),
      ],
    );
  }
}
