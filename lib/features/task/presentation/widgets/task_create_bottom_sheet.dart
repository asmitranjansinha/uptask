import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uptask/features/task/presentation/bloc/task_bloc.dart';
import 'package:uptask/features/task/presentation/bloc/task_event.dart';
import 'package:uptask/features/task/presentation/widgets/task_field.dart';

class TaskCreateBottomSheet extends StatefulWidget {
  const TaskCreateBottomSheet({super.key});

  @override
  State<TaskCreateBottomSheet> createState() => _TaskCreateBottomSheetState();
}

class _TaskCreateBottomSheetState extends State<TaskCreateBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDueDate;
  String _selectedPriority = 'Medium';

  void _pickDueDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDueDate = pickedDate;
      });
    }
  }

  void _submitTask() {
    if (_formKey.currentState!.validate() && _selectedDueDate != null) {
      context.read<TaskBloc>().add(CreateTaskEvent(_titleController.text,
          _descriptionController.text, _selectedDueDate!, _selectedPriority));

      Navigator.pop(context);
    }
  }

  void _selectPriority(String priority) {
    setState(() {
      _selectedPriority = priority;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Task',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TaskField(
                controller: _titleController,
                hintText: 'Title',
                validator: (value) => value!.isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 10),
              TaskField(
                controller: _descriptionController,
                hintText: 'Description',
                isDescription: true,
                validator: (value) =>
                    value!.isEmpty ? 'Enter description' : null,
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              ListTile(
                title: Text(
                  _selectedDueDate == null
                      ? 'Select Due Date'
                      : 'Due Date: ${_selectedDueDate?.toLocal().toString().split(' ')[0]}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickDueDate(context),
              ),
              Divider(
                color: Colors.grey.shade300,
              ),
              Text(
                'Priority :-',
                style: GoogleFonts.fredoka(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              5.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPriorityDot('Low', Colors.green),
                  _buildPriorityDot('Medium', Colors.orange),
                  _buildPriorityDot('High', Colors.red),
                ],
              ),
              10.verticalSpace,
              ElevatedButton(
                onPressed: _submitTask,
                child: const Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityDot(String priority, Color color) {
    bool isSelected = _selectedPriority == priority;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: InkWell(
        onTap: () => _selectPriority(priority),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            border: Border.all(
              color: color,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(35.sp),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10.sp,
            vertical: 5.sp,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                priority,
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              if (isSelected)
                Row(
                  children: [
                    20.horizontalSpace,
                    Icon(
                      CupertinoIcons.check_mark,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
