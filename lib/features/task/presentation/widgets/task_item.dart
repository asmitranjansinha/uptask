// features/task/presentation/widgets/task_item.dart
import 'package:flutter/material.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          // Update task status
        },
      ),
    );
  }
}
