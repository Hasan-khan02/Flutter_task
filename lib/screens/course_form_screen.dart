import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/course_controller.dart';
import '../models/course_model.dart';

class CourseFormScreen extends StatefulWidget {
  final Course? course;
  const CourseFormScreen({super.key, this.course});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.course?.title ?? '';
    description = widget.course?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CourseController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(widget.course == null ? 'Add Course' : 'Edit Course')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => description = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.course == null ? 'Add' : 'Update'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final course = Course(id: widget.course?.id, title: title, description: description);
                    if (widget.course == null) {
                      await controller.addCourse(course);
                    } else {
                      await controller.updateCourse(course);
                    }
                    if (mounted) Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}