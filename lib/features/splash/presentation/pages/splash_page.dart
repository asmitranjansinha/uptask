import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptask/core/constants/app_media.dart';
import 'package:uptask/core/service_locator.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) {
                context.go('/login');
              }
            });
          } else if (state is AuthInitial) {
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) {
                context.go('/login');
              }
            });
          }
        },
        child: Scaffold(
          body: Center(
            child: Lottie.asset(
              AppMedia.taskCompletedSplash,
              height: 200.h,
            ),
          ),
        ),
      ),
    );
  }
}
