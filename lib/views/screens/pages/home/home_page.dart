import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/views/screens/pages/home/grid_view.dart';
import 'package:practice_home/views/screens/pages/home/list_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListView = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CoursesController>(context, listen: false).fetchCourses();
    });
    loadViewPreference();
  }

  Future<void> saveBool(bool isListView) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool("isListView", isListView);
  }

  Future<void> loadViewPreference() async {
    var prefs = await SharedPreferences.getInstance();
    bool? savedIsListView = prefs.getBool("isListView");
    setState(() {
      isListView = savedIsListView ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CoursesController>(context).courses;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.courses,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isListView = !isListView;
                    saveBool(isListView);
                  });
                },
                icon: !isListView
                    ? const Icon(Icons.format_list_bulleted)
                    : const Icon(Icons.grid_view_rounded),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isListView
                ? ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return ListViewCourses(
                        course: courses[index],
                      );
                    },
                  )
                : GridView.builder(
                    itemCount: courses.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.3,
                    ),
                    itemBuilder: (context, index) {
                      return GridViewCourses(
                        course: courses[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
