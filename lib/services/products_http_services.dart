import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_home/models/course.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsHttpServices {
  Future<List<Course>> getProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");

    Uri url = Uri.parse(
        'https://todo-5224b-default-rtdb.firebaseio.com/courses.json?orderBy="userId"&equalTo="$userId"');

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Course> courses = [];

    if (data != null) {
      data.forEach((key, value) {
        courses.add(Course.fromJson(value));
      });
    }

    return courses;
  }

  // Future<void> addProduct(String title) async {
  //   Uri url = Uri.parse(
  //       "https://dars46-7f132-default-rtdb.firebaseio.com/products.json");
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? userId = sharedPreferences.getString("userId");

  //   final response = await http.post(
  //     url,
  //     body: jsonEncode(
  //       {
  //         "title": title,
  //         "userId": userId,
  //       },
  //     ),
  //   );

  //   print(response.body);
  // }
}
