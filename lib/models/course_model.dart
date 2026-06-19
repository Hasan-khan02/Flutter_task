import 'package:hive/hive.dart';

part 'course_model.g.dart'; // auto-generated

@HiveType(typeId: 0)
class Course extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  Course({this.id, required this.title, required this.description});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': description,
    };
  }

  Course copyWith({int? id, String? title, String? description}) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}