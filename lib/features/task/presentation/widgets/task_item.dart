// features/task/presentation/widgets/task_item.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';

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
            Text(
              task.title,
              style: GoogleFonts.fredoka(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              task.description,
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
    );
  }
}
