import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/providers/index_provider.dart';
import 'package:practice_home/theme/theme_provider.dart';
import 'package:practice_home/views/screens/home_screen.dart';
import 'package:practice_home/views/screens/pages/home/screens_in.dart/course_detail.dart';
import 'package:practice_home/views/screens/pages/home/screens_in.dart/lesson_detail.dart';
import 'package:practice_home/views/screens/pages/home/screens_in.dart/quiz.dart';
import 'package:practice_home/views/widgets/drawer/screens/edit_courses.dart';
import 'package:practice_home/views/widgets/drawer/screens/settings.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<IndexProvider>(create: (_) => IndexProvider()),
        ChangeNotifierProvider<CoursesController>(
            create: (_) => CoursesController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        "home": (ctx) => const HomeScreen(),
        'course_detail': (ctx) => const CourseDetail(),
        'edit_course': (ctx) => const EditCourses(),
        'settings': (ctx) => const Settings(),
        'lesson_detail': (ctx) => const LessonDetail(),
        'quiz_game': (ctx) => const QuizGame(),
      },
    );
  }
}
