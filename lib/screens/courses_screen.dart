import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/course_controller.dart';
import 'course_form_screen.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseController()..getCourses(),
      child: Scaffold(
        appBar: AppBar(title: Text('Courses')),
        body: Consumer<CourseController>(
          builder: (context, controller, _) {
            if (controller.isLoading) return Center(child: CircularProgressIndicator());
            if (controller.errorMessage != null) return Center(child: Text(controller.errorMessage!));
            return ListView.builder(
              itemCount: controller.courses.length,
              itemBuilder: (context, index) {
                final course = controller.courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(course.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CourseFormScreen(course: course),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          final confirmed = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Delete?'),
                              content: Text('Are you sure you want to delete this course?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
                                TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete')),
                              ],
                            ),
                          );
                          if (confirmed) controller.deleteCourse(course.id!);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CourseFormScreen())),
        ),
      ),
    );
  }
}