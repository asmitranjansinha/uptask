// features/task/presentation/pages/task_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptask/core/service_locator.dart';
import 'package:uptask/features/task/presentation/bloc/task_bloc.dart';
import 'package:uptask/features/task/presentation/bloc/task_event.dart';
import 'package:uptask/features/task/presentation/bloc/task_state.dart';
import 'package:uptask/features/task/presentation/widgets/task_item.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskBloc>()..add(GetTasksEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Tasks')),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              final tasks = state.tasks
                ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(task: tasks[index]);
                },
              );
            } else if (state is TaskFailure) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('No tasks found'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to TaskFormPage
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
