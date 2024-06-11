import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/views/screens/pages/home/grid_view.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<CoursesController>(context)
              .fetchCoursesFavoriteAndInCart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Snapshot error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return const Center(
                child: Text("Snapshot hasData error: Malumot topilmadi"),
              );
            }
            final courses =
                Provider.of<CoursesController>(context, listen: false)
                    .favoriteCourses;
            if (courses.isEmpty) {
              return const Center(
                child: Text("Malumot yo'q"),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: courses.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 0,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.3,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridViewCourses(
                          course: courses[index],
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}
