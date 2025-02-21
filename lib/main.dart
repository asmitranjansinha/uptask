import 'package:flutter/material.dart';
import 'package:uptask/core/constants/app_strings.dart';
import 'package:uptask/core/theme/app_theme.dart';

void main() {
  runApp(const UpTask());
}

class UpTask extends StatelessWidget {
  const UpTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Applying the theme
    );
  }
}
