import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/views/widgets/drawer/screens/list_view_edit.dart';
import 'package:provider/provider.dart';

class EditCourses extends StatefulWidget {
  const EditCourses({super.key});

  @override
  State<EditCourses> createState() => _EditCoursesState();
}

class _EditCoursesState extends State<EditCourses> {
  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CoursesController>(context).courses;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Courses"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return ListViewCoursesEdit(
            course: courses[index],
          );
        },
      ),
    );
  }
}
