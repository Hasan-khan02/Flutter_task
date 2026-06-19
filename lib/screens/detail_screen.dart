import 'package:flutter/material.dart';
import '../models/course_model.dart';

class DetailScreen extends StatelessWidget {
  final Course course;

  const DetailScreen({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Column(
        children: [
          Image.network('https://picsum.photos/300'),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(course.description),
                SizedBox(height: 20),
                Text("Course overview"),
                Text("Timing : 9 AM - 11 AM"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}