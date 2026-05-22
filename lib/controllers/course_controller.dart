import '../models/course_model.dart';
import '../services/course_service.dart';
import 'package:flutter/material.dart';

class CourseController extends ChangeNotifier {
  final CourseService _service = CourseService();
  List<Course> courses = [];
  bool isLoading = false;
  String? errorMessage;

  // Fetch courses
  Future<void> getCourses() async {
    isLoading = true;
    notifyListeners();
    try {
      courses = await _service.fetchCourses();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  // Add course
  Future<void> addCourse(Course course) async {
    isLoading = true;
    notifyListeners();
    try {
      final newCourse = await _service.addCourse(course);
      courses.insert(0, newCourse);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  // Update course
  Future<void> updateCourse(Course course) async {
    isLoading = true;
    notifyListeners();
    try {
      final updatedCourse = await _service.updateCourse(course);
      final index = courses.indexWhere((c) => c.id == course.id);
      if (index != -1) courses[index] = updatedCourse;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  // Delete course
  Future<void> deleteCourse(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      await _service.deleteCourse(id);
      courses.removeWhere((c) => c.id == id);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}