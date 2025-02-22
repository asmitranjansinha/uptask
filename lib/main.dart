import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptask/core/routes/app_router.dart';
import 'package:uptask/core/theme/app_theme.dart';
import 'package:uptask/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:uptask/features/auth/domain/usecases/login_user.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptask/firebase_options.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            remoteDataSource: AuthRemoteDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              loginUser: LoginUser(context.read<AuthRepositoryImpl>()),
              registerUser: RegisterUser(context.read<AuthRepositoryImpl>()),
              logoutUser: LogoutUser(context.read<AuthRepositoryImpl>()),
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
        ),
      ),
    );
  }
}
