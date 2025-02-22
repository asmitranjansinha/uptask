// features/task/presentation/pages/task_form_page.dart
import 'package:flutter/material.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';

class TaskFormPage extends StatelessWidget {
  final TaskEntity? task;

  const TaskFormPage({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            // Add more fields for dueDate, priority, etc.
          ],
        ),
      ),
    );
  }
}
