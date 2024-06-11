import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/models/course.dart';
import 'package:provider/provider.dart';

class CourseDetail extends StatefulWidget {
  CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  // bool isLoading = false;

  // void updateFavoCart() async {
  //   await Provider.of<CoursesController>(context)
  //       .fetchCoursesFavoriteAndInCart();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   updateFavoCart();
  // }

  @override
  Widget build(BuildContext context) {
    final Course course = ModalRoute.of(context)!.settings.arguments as Course;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course detail"),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<CoursesController>(context, listen: false)
                  .setFavorite(course);
            },
            icon: (course.isFavorite)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Color.fromARGB(255, 189, 7, 255),
                  ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<CoursesController>(context, listen: false)
                  .setCart(course);
            },
            icon: course.isInCart
                ? const Icon(
                    CupertinoIcons.cart_badge_minus,
                    color: Colors.red,
                  )
                : const Icon(
                    CupertinoIcons.cart_badge_plus,
                    color: Color.fromARGB(255, 189, 7, 255),
                  ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 230,
                  width: 400,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.network(course.imageUrl),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    course.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Divider(
                    height: 30,
                  ),
                  const Text(
                    "Lessons",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: course.lessons.length,
                itemBuilder: (context, indexLesson) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, 'lesson_detail',
                            arguments: course.lessons[indexLesson]);
                      },
                      title: Text(course.lessons[indexLesson].title),
                      subtitle: Text(course.lessons[indexLesson].description),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
