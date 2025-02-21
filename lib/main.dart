import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uptask/core/constants/app_strings.dart';
import 'package:uptask/core/theme/app_theme.dart';
import 'package:uptask/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
