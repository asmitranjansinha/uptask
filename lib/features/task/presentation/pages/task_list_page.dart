import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';
import 'package:uptask/features/task/presentation/bloc/task_bloc.dart';
import 'package:uptask/features/task/presentation/bloc/task_state.dart';
import 'package:uptask/features/task/presentation/widgets/task_create_bottom_sheet.dart';
import 'package:uptask/features/task/presentation/widgets/task_item.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  void _showTaskCreateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const TaskCreateBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded || state is TaskLoadingWithData) {
            final tasks = state is TaskLoaded
                ? state.tasks
                : (state as TaskLoadingWithData).tasks;

            final groupedTasks = _groupTasksByDate(tasks);

            return ListView(
              children: _getSortedKeys(groupedTasks).map((key) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 4.sp, horizontal: 16.0),
                      child: Text(
                        key,
                        style: GoogleFonts.fredoka(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ...groupedTasks[key]!.map((task) => TaskItem(task: task)),
                  ],
                );
              }).toList(),
            );
          } else if (state is TaskFailure) {
            return Center(child: Text(state.error));
          }
          return Center(
            child: InkWell(
              onTap: () => _showTaskCreateBottomSheet(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start Creating Tasks',
                    style: GoogleFonts.fredoka(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  10.horizontalSpace,
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 143, 124, 237),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded && state.tasks.isNotEmpty) {
            return FloatingActionButton(
              onPressed: () => _showTaskCreateBottomSheet(context),
              child: Icon(
                CupertinoIcons.plus,
                size: 25.sp,
                color: Colors.white,
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Map<String, List<TaskEntity>> _groupTasksByDate(List<TaskEntity> tasks) {
    final Map<String, List<TaskEntity>> groupedTasks = {};

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));

    for (var task in tasks) {
      final taskDate =
          DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);

      String category;
      if (taskDate == today) {
        category = 'Today';
      } else if (taskDate == tomorrow) {
        category = 'Tomorrow';
      } else if (taskDate == yesterday) {
        category = 'Yesterday';
      } else {
        category = DateFormat('EEEE').format(taskDate);
      }

      groupedTasks.putIfAbsent(category, () => []).add(task);
    }

    return groupedTasks;
  }

  List<String> _getSortedKeys(Map<String, List<TaskEntity>> groupedTasks) {
    List<String> keys = groupedTasks.keys.toList();

    keys.sort((a, b) {
      if (a == 'Today') return -1;
      if (b == 'Today') return 1;
      if (a == 'Tomorrow') return -1;
      if (b == 'Tomorrow') return 1;
      if (a == 'Yesterday') return 1;
      if (b == 'Yesterday') return -1;
      return 0;
    });

    return keys;
  }
}
