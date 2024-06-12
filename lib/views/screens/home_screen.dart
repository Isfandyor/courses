import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/models/course.dart';
import 'package:practice_home/providers/index_provider.dart';
import 'package:practice_home/views/screens/pages/home/cart_page.dart';
import 'package:practice_home/views/screens/pages/home/favorite_page.dart';
import 'package:practice_home/views/screens/pages/notes_page.dart';
import 'package:practice_home/views/screens/pages/home/home_page.dart';
import 'package:practice_home/views/screens/pages/profile_page.dart';
import 'package:practice_home/views/screens/pages/search_view_delegate.dart';
import 'package:practice_home/views/widgets/bottom_navigation_bar.dart';
import 'package:practice_home/views/widgets/drawer/my_drawer.dart';
import 'package:practice_home/views/widgets/navigation_rail.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [];
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    pages = [
      const HomePage(),
      const FavoritePage(),
      const CartPage(),
      const NotesPage(),
      const ProfilePage(),
    ];
  }

  late int index;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    index = Provider.of<IndexProvider>(context).currentIndex;
    return Scaffold(
      drawer: const MyDrawer(),
      bottomNavigationBar:
          widthScreen < 500 ? const MyBottomNavigationBar() : null,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Todo",
          style: TextStyle(
            fontFamily: "Agbalumo",
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: SearchViewDelegate(courses =
                    Provider.of<CoursesController>(context, listen: false)
                        .courses),
              );
            },
            icon: Icon(CupertinoIcons.search),
          )
        ],
      ),
      body: widthScreen >= 500
          ? Row(
              children: [
                const MyNavigationRail(),
                Expanded(child: pages[index]),
              ],
            )
          : Column(
              children: [
                Expanded(child: pages[index]),
              ],
            ),
    );
  }
}
