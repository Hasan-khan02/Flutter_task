import 'package:hive_flutter/hive_flutter.dart';
import '../models/course_model.dart';

class CourseLocalDatasource {
  static const String _boxName = 'courses';

  Future<Box<Course>> get _box async => Hive.openBox<Course>(_boxName);

  Future<List<Course>> getCourses() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<void> saveCourses(List<Course> courses) async {
    final box = await _box;
    await box.clear();
    for (final course in courses) {
      await box.put(course.id, course);
    }
  }

  Future<void> addCourse(Course course) async {
    final box = await _box;
    await box.put(course.id, course);
  }

  Future<void> updateCourse(Course course) async {
    final box = await _box;
    await box.put(course.id, course);
  }

  Future<void> deleteCourse(int id) async {
    final box = await _box;
    await box.delete(id);
  }

  Future<void> clearAll() async {
    final box = await _box;
    await box.clear();
  }
}