import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uptask/core/routes/app_router.dart';
import 'package:uptask/core/service_locator.dart';
import 'package:uptask/core/theme/app_theme.dart';
import 'package:uptask/core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize getIt
  await init();

  runApp(const UpTask());
}

class UpTask extends StatelessWidget {
  const UpTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
