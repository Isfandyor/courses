import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice_home/models/course.dart';

class CourseHttpService {
  Future<List<Course>> getCoursesFromHttpService() async {
    Uri url = Uri.parse(
        "https://todo-5224b-default-rtdb.firebaseio.com/courses.json");
    final response = await http.get(url);
    // print("Data ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print("Data $data");
      List<Course> courses = [];
      data.forEach((key, value) {
        Course course = Course.fromJson(value);
        course.id = key; // Assign the Firebase key to the course id
        courses.add(course);
      });

      return courses;
    } else {
      throw Exception("Error fetching courses: ${response.statusCode}");
    }
  }

  // Future<void> addCourse(Course course) async {
  //   Uri url = Uri.parse("https://todo-5224b-default-rtdb.firebaseio.com/courses.json");
  //   final response = await http.post(
  //     url,
  //     body: jsonEncode(course.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     final responseBody = jsonDecode(response.body);
  //     print('Response: $responseBody');
  //   } else {
  //     print('Failed to make POST request. Status code: ${response.statusCode}');
  //   }
  // }

  Future<void> updateIsFavorite(String courseId, bool isFavorite) async {
    Uri url = Uri.parse(
        "https://todo-5224b-default-rtdb.firebaseio.com/courses/$courseId.json");
    final response = await http.patch(
      url,
      body: jsonEncode({'isFavorite': isFavorite}),
    );

    if (response.statusCode == 200) {
      print('Updated isFavorite successfully');
    } else {
      print('Failed to update isFavorite. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateCart(String courseId, bool isInCart) async {
    Uri url = Uri.parse(
        "https://todo-5224b-default-rtdb.firebaseio.com/courses/$courseId.json");
    final response = await http.patch(
      url,
      body: jsonEncode({'isInCart': isInCart}),
    );

    if (response.statusCode == 200) {
      print('Updated isFavorite successfully');
    } else {
      print('Failed to update isFavorite. Status code: ${response.statusCode}');
    }
  }
}
