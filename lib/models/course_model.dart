class Course {
  int? id;
  String title;
  String description;

  Course({this.id, required this.title, required this.description});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['body'] ?? '', // JSONPlaceholder uses 'body' for description
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': description,
    };
  }
}