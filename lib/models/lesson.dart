import 'package:json_annotation/json_annotation.dart';
import 'package:practice_home/models/quiz.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson {
  String id;
  String courseId;
  String title;
  String description;
  String videoUrl;
  List<Quiz> quizzes;
  Lesson({
    required this.id,
    required this.title,
    required this.courseId,
    required this.videoUrl,
    required this.description,
    required this.quizzes,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return _$LessonFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LessonToJson(this);
  }
}
