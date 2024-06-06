import 'package:flutter/material.dart';
import 'package:practice_home/models/course.dart';
import 'package:practice_home/services/course_http_service.dart';

class CoursesController extends ChangeNotifier {
  final _courseHttpService = CourseHttpService();
  List<Course> _courses = [];

  Future<void> fetchCourses() async {
    try {
      _courses = await _courseHttpService.getCoursesFromHttpService();
      notifyListeners();
    } on Exception catch (error) {
      print("Error fetching courses: $error");
    }
  }






  List<Course> get courses => _courses;
}
