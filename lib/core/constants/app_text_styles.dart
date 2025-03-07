import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle displayLarge = GoogleFonts.fredoka(
    fontSize: 36.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle displayMedium = GoogleFonts.fredoka(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle displaySmall = GoogleFonts.fredoka(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle headlineLarge = GoogleFonts.fredoka(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle headlineMedium = GoogleFonts.fredoka(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle headlineSmall = GoogleFonts.fredoka(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle titleLarge = GoogleFonts.fredoka(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle titleMedium = GoogleFonts.fredoka(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static final TextStyle titleSmall = GoogleFonts.fredoka(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static final TextStyle bodyLarge = GoogleFonts.fredoka(
    fontSize: 16.sp,
    color: AppColors.text,
  );

  static final TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: AppColors.text,
  );

  static final TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 12.sp,
    color: AppColors.text,
  );

  static final TextStyle labelLarge = GoogleFonts.fredoka(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.buttonText,
  );

  static final TextStyle labelMedium = GoogleFonts.fredoka(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.buttonText,
  );

  static final TextStyle labelSmall = GoogleFonts.fredoka(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.buttonText,
  );
}
