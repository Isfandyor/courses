import 'package:json_annotation/json_annotation.dart';
import 'package:practice_home/models/lesson.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  String id;
  String title;
  double price;
  String imageUrl;
  String description;
  List<Lesson> lessons;

  Course({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.lessons,
  });
  factory Course.fromJson(Map<String, dynamic> json) {
    return _$CourseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CourseToJson(this);
  }
}