import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';
import 'package:uptask/features/task/presentation/bloc/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptask/features/task/presentation/bloc/task_event.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      child: task.isCompleted
          ? _completedTaskTile(context)
          : InkWell(
              onTap: () => _showTaskDetails(context),
              child: SwipeTo(
                iconOnLeftSwipe: CupertinoIcons.delete_solid,
                iconColor: Colors.red,
                onLeftSwipe: (details) {
                  BlocProvider.of<TaskBloc>(context)
                      .add(DeleteTaskEvent(task.id));
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250.w,
                            child: Text(
                              task.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.fredoka(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(CupertinoIcons.ellipsis),
                        ],
                      ),
                      Text(
                        task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.fredoka(
                          fontSize: 15.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      10.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          color: task.priority == 'Low'
                              ? Colors.green
                              : task.priority == 'Medium'
                                  ? Colors.orangeAccent
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(35.sp),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                          vertical: 5.sp,
                        ),
                        child: Text(
                          task.priority,
                          style: GoogleFonts.fredoka(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  _completedTaskTile(context) {
    return InkWell(
      onTap: () => _showTaskDetails(context),
      child: SwipeTo(
        iconOnLeftSwipe: CupertinoIcons.delete_solid,
        iconColor: Colors.red,
        onLeftSwipe: (details) {
          BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(task.id));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15.sp),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.check_mark_circled,
                        color: Colors.grey,
                      ),
                      10.horizontalSpace,
                      Text(
                        task.title,
                        style: GoogleFonts.fredoka(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: task.priority == 'Low'
                          ? Colors.green.shade200
                          : task.priority == 'Medium'
                              ? Colors.orangeAccent.shade100
                              : Colors.red.shade200,
                      borderRadius: BorderRadius.circular(35.sp),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                      vertical: 5.sp,
                    ),
                    child: Text(
                      task.priority,
                      style: GoogleFonts.fredoka(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              SizedBox(height: 10.h),
              Text('Due Date: ${task.dueDate.toString().split(' ')[0]}'),
              SizedBox(height: 10.h),
              Text('Priority: ${task.priority}'),
              SizedBox(height: 10.h),
              Text('Status: ${task.isCompleted ? 'Completed' : 'Incomplete'}'),
            ],
          ),
          actions: [
            task.isCompleted
                ? SizedBox.shrink()
                : TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _editTask(context);
                    },
                    child: Text('Edit'),
                  ),
            TextButton(
              onPressed: () {
                taskBloc.add(DeleteTaskEvent(task.id));
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
            task.isCompleted
                ? SizedBox.shrink()
                : TextButton(
                    onPressed: () {
                      taskBloc.add(
                          UpdateTaskEvent(task.copyWith(isCompleted: true)));
                      Navigator.pop(context);
                    },
                    child: Text('Mark Complete'),
                  ),
          ],
        );
      },
    );
  }

  void _editTask(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    String priority = task.priority;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              DropdownButton<String>(
                value: priority,
                onChanged: (String? newValue) {
                  priority = newValue!;
                },
                items: <String>['Low', 'Medium', 'High']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedTask = task.copyWith(
                  title: titleController.text,
                  description: descriptionController.text,
                  priority: priority,
                );
                taskBloc.add(UpdateTaskEvent(updatedTask));
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
