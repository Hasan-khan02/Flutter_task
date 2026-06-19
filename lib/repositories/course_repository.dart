import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/course_model.dart';
import '../services/course_service.dart';
import '../local/course_local_datasource.dart';

class CourseRepository {
  final CourseService _apiService;
  final CourseLocalDatasource _localDatasource;

  CourseRepository({
    CourseService? apiService,
    CourseLocalDatasource? localDatasource,
  })  : _apiService = apiService ?? CourseService(),
        _localDatasource = localDatasource ?? CourseLocalDatasource();

  // Check internet connectivity
  // Future<bool> _isOnline() async {
  //   final result = await Connectivity().checkConnectivity();
  //   return result != ConnectivityResult.none;
  // }
  Future<bool> _isOnline() async {
  return false; // Force offline mode
}

  // GET: Online se fetch karo, offline mein local se
  Future<List<Course>> getCourses() async {
    if (await _isOnline()) {
      try {
        final courses = await _apiService.fetchCourses();
        await _localDatasource.saveCourses(courses); // local mein save
        return courses;
      } catch (e) {
        // API fail hojaye toh local se lo
        return await _localDatasource.getCourses();
      }
    } else {
      return await _localDatasource.getCourses();
    }
  }

  // POST
  Future<Course> addCourse(Course course) async {
    if (await _isOnline()) {
      final newCourse = await _apiService.addCourse(course);
      await _localDatasource.addCourse(newCourse);
      return newCourse;
    } else {
      throw Exception('No internet connection. Cannot add course offline.');
    }
  }

  // PUT
  Future<Course> updateCourse(Course course) async {
    if (await _isOnline()) {
      final updated = await _apiService.updateCourse(course);
      await _localDatasource.updateCourse(updated);
      return updated;
    } else {
      throw Exception('No internet connection. Cannot update course offline.');
    }
  }

  // DELETE
  Future<void> deleteCourse(int id) async {
    if (await _isOnline()) {
      await _apiService.deleteCourse(id);
      await _localDatasource.deleteCourse(id);
    } else {
      throw Exception('No internet connection. Cannot delete course offline.');
    }
  }
}