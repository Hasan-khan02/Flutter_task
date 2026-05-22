import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/registration_screen.dart';
import 'screens/courses_screen.dart';
import 'controllers/course_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CourseController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter CRUD App',
        // You can switch between RegistrationScreen() or CoursesScreen() here
        home: CoursesScreen(),
      ),
    );
  }
}