import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uptask/features/auth/presentation/pages/login_page.dart';
import 'package:uptask/features/auth/presentation/pages/register_page.dart';
import 'package:uptask/features/splash/splash_page.dart';
import 'package:uptask/features/task/presentation/pages/task_form_page.dart';
import 'package:uptask/features/task/presentation/pages/task_home_page.dart';
import 'package:uptask/features/task/presentation/pages/task_list_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/tasks/list',
        name: 'tasksList',
        builder: (context, state) => TaskListPage(),
      ),
    ],
  );
}
