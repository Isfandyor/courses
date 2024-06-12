import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/models/course.dart';
import 'package:provider/provider.dart';

class GridViewCourses extends StatelessWidget {
  Course course;
  GridViewCourses({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'course_detail', arguments: course);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              width: 180,
              height: 120,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.network(
                course.imageUrl,
                alignment: const Alignment(0.5, 1),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Text(
                        "\$${course.price}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                  Text(
                    course.description,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
