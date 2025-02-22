// features/task/presentation/widgets/task_filter.dart
import 'package:flutter/material.dart';

class TaskFilter extends StatelessWidget {
  const TaskFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          items: const [
            DropdownMenuItem(value: 'low', child: Text('Low')),
            DropdownMenuItem(value: 'medium', child: Text('Medium')),
            DropdownMenuItem(value: 'high', child: Text('High')),
          ],
          onChanged: (value) {
            // Filter tasks by priority
          },
        ),
        DropdownButton<String>(
          items: const [
            DropdownMenuItem(value: 'completed', child: Text('Completed')),
            DropdownMenuItem(value: 'incomplete', child: Text('Incomplete')),
          ],
          onChanged: (value) {
            // Filter tasks by status
          },
        ),
      ],
    );
  }
}
