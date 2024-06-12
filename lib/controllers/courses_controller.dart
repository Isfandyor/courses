import 'package:flutter/material.dart';
import 'package:practice_home/models/course.dart';
import 'package:practice_home/services/course_http_service.dart';

class CoursesController extends ChangeNotifier {
  final _courseHttpService = CourseHttpService();
  List<Course> _courses = [];
  final List<Course> _favoriteCourses = [];
  final List<Course> _coursesInCart = [];

  Future<void> fetchCourses() async {
    try {
      _courses = await _courseHttpService.getCoursesFromHttpService();
      notifyListeners();
    } on Exception catch (error) {
      print("Error fetching courses: $error");
    }
  }

  Future<void> fetchCoursesFavoriteAndInCart() async {
    try {
      _courses = await _courseHttpService.getCoursesFromHttpService();
      _favoriteCourses.clear();
      _coursesInCart.clear();
      for (var course in _courses) {
        if (course.isFavorite) {
          _favoriteCourses.add(course);
        }
        if (course.isInCart) {
          _coursesInCart.add(course);
        }
      }
    } catch (e) {
      print('Error fetching favorite and inCart: $e');
    }
  }

  Future<void> setFavorite(Course course) async {
    try {
      await _courseHttpService.updateIsFavorite(course.id, !course.isFavorite);
      notifyListeners();
    } catch (e) {
      print("Error in set favorite: $e");
    }
  }

  Future<void> setCart(Course course) async {
    try {
      await _courseHttpService.updateCart(course.id, !course.isInCart);
      notifyListeners();
    } catch (e) {
      print("Error in set cart: $e");
    }
  }

  double totalPriceCart() {
    double total = 0;
    for (var course in _coursesInCart) {
      total += course.price;
    }
    notifyListeners();
    return total;
  }

  List<Course> get favoriteCourses => _favoriteCourses;
  List<Course> get coursesInCart => _coursesInCart;
  List<Course> get courses => _courses;
}
