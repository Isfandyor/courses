import 'package:flutter/material.dart';
import 'package:practice_home/providers/index_provider.dart';
import 'package:practice_home/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.note_alt_outlined,
          ),
          label: "Notes",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      onTap: Provider.of<IndexProvider>(context).selectedIndex,
    );
  }
}
