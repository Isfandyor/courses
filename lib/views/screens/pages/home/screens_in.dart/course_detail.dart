import 'package:flutter/material.dart';
import 'package:practice_home/models/course.dart';

class CourseDetail extends StatelessWidget {
  // final Course course;
  const CourseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Course course = ModalRoute.of(context)!.settings.arguments as Course;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course detail"),
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
