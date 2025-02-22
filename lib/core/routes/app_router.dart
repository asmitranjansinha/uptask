import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uptask/features/auth/presentation/pages/login_page.dart';
import 'package:uptask/features/auth/presentation/pages/register_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // GoRoute(
      //   path: '/',
      //   name: 'splash',
      //   builder: (context, state) => const SplashPage(),
      // ),
      GoRoute(
        path: '/',
        name: 'login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => RegisterPage(),
      ),
      // GoRoute(
      //   path: '/home',
      //   name: 'home',
      //   builder: (context, state) => const HomePage(),
      // ),
      // GoRoute(
      //   path: '/task/create',
      //   name: 'taskCreate',
      //   builder: (context, state) => const TaskCreatePage(),
      // ),
      // GoRoute(
      //   path: '/task/:id',
      //   name: 'taskDetail',
      //   builder: (context, state) {
      //     final String taskId = state.pathParameters['id']!;
      //     return TaskDetailPage(taskId: taskId);
      //   },
      // ),
    ],
  );
}
