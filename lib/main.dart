import 'package:flutter/material.dart';
import 'package:practice_home/controllers/courses_controller.dart';
import 'package:practice_home/providers/index_provider.dart';
import 'package:practice_home/theme/theme_provider.dart';
import 'package:practice_home/views/screens/home_screen.dart';
import 'package:practice_home/views/screens/pages/home/screens_in.dart/course_detail.dart';
import 'package:practice_home/views/screens/pages/home/screens_in.dart/lesson_detail.dart';
import 'package:practice_home/views/screens/pages/home/screens_in.dart/quiz.dart';
import 'package:practice_home/views/screens/pages/introduction/login_screens/login/screens/login_page.dart';
import 'package:practice_home/views/screens/pages/introduction/start_screen.dart';
import 'package:practice_home/views/widgets/drawer/screens/edit_courses.dart';
import 'package:practice_home/views/widgets/drawer/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(List<String> args) {
  // // Initialize FFI
  // sqfliteFfiInit();

  // // Change the default factory to FFI
  // databaseFactory = databaseFactoryFfi;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<IndexProvider>(create: (_) => IndexProvider()),
        ChangeNotifierProvider<ChangeLangauge>(create: (_) => ChangeLangauge()),
        ChangeNotifierProvider<CoursesController>(
            create: (_) => CoursesController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  List<String> languages = [
    "uz",
    "ru",
    "en",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      // themeMode: ThemeMode.dark,
      // theme: ThemeData.dark(),
      locale: Locale(languages[Provider.of<ChangeLangauge>(context).index]),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'start_screen': (ctx) => const StartScreen(),
        'login': (ctx) => const LoginPage(),
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

class ChangeLangauge extends ChangeNotifier {
  int _index = 2;

  int get index => _index;

  void selectedLangauge(int value) {
    _index = value;
    notifyListeners();
  }
}
