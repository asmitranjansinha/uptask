import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool isDescription;
  const TaskField(
      {super.key,
      required this.controller,
      this.validator,
      this.hintText,
      this.isDescription = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: isDescription ? 5 : 1,
      minLines: isDescription ? 3 : 1,
      style: GoogleFonts.fredoka(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: Colors.black54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: Colors.black),
        ),
        hintStyle: GoogleFonts.fredoka(
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
        ),
        hintText: hintText,
      ),
    );
  }
}
