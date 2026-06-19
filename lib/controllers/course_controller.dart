import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../repositories/course_repository.dart';

class CourseController extends ChangeNotifier {
  final CourseRepository _repository;

  CourseController({CourseRepository? repository})
      : _repository = repository ?? CourseRepository();

  List<Course> courses = [];
  List<Course> filteredCourses = [];
  bool isLoading = false;
  String? errorMessage;
  String _searchQuery = '';
  bool isOffline = false;

  // Fetch courses
  Future<void> getCourses() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      courses = await _repository.getCourses();
      isOffline = false;
      _applySearch();
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  // Search/filter
  void searchCourses(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      filteredCourses = List.from(courses);
    } else {
      filteredCourses = courses.where((c) {
        return c.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            c.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  // Add course
  Future<void> addCourse(Course course) async {
    isLoading = true;
    notifyListeners();
    try {
      final newCourse = await _repository.addCourse(course);
      courses.insert(0, newCourse);
      _applySearch();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  // Update course — OPTIMISTIC UPDATE
  Future<void> updateCourse(Course course) async {
    final index = courses.indexWhere((c) => c.id == course.id);
    Course? original;

    if (index != -1) {
      original = courses[index]; // backup
      courses[index] = course;  // optimistic update (immediate UI change)
      _applySearch();
      notifyListeners();
    }

    try {
      final updated = await _repository.updateCourse(course);
      if (index != -1) courses[index] = updated;
      errorMessage = null;
    } catch (e) {
      // Rollback on failure
      if (index != -1 && original != null) {
        courses[index] = original;
      }
      errorMessage = e.toString();
    }
    _applySearch();
    notifyListeners();
  }

  // Delete course — OPTIMISTIC UPDATE
  Future<void> deleteCourse(int id) async {
    final index = courses.indexWhere((c) => c.id == id);
    Course? removed;

    if (index != -1) {
      removed = courses[index]; // backup
      courses.removeAt(index);  // optimistic delete
      _applySearch();
      notifyListeners();
    }

    try {
      await _repository.deleteCourse(id);
      errorMessage = null;
    } catch (e) {
      // Rollback on failure
      if (removed != null && index != -1) {
        courses.insert(index, removed);
      }
      errorMessage = e.toString();
    }
    _applySearch();
    notifyListeners();
  }
}