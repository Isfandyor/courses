import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:practice_home/views/screens/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Future<Map<String, dynamic>> getString() async {
    var prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString("user_data") ?? jsonEncode({}));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 50,
                ),
                const Gap(10),
                SizedBox(
                  width: 170,
                  child: Text(
                    ProfilePage.fullname,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(25),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'edit_course');
              },
              title: const Text("Edit courses"),
              leading: const Icon(Icons.edit_outlined),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'settings');
              },
              title: const Text("Settings"),
              leading: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
