// core/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptask/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:uptask/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:uptask/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:uptask/features/auth/domain/repositories/auth_repository.dart';
import 'package:uptask/features/auth/domain/usecases/check_login_status.dart';
import 'package:uptask/features/auth/domain/usecases/login_user.dart';
import 'package:uptask/features/auth/domain/usecases/logout_user.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptask/features/task/data/datasources/task_remote_datasource.dart';
import 'package:uptask/features/task/data/repositories/task_repository_impl.dart';
import 'package:uptask/features/task/domain/repositories/task_repository.dart';
import 'package:uptask/features/task/domain/usecases/create_task.dart';
import 'package:uptask/features/task/domain/usecases/delete_task.dart';
import 'package:uptask/features/task/domain/usecases/get_task.dart';
import 'package:uptask/features/task/domain/usecases/update_task.dart';
import 'package:uptask/features/task/presentation/bloc/task_bloc.dart';

import '../features/auth/domain/usecases/register_user.dart';

final GetIt sl = GetIt.instance;

init() async {
  // Register BLoCs

  /// AuthBloc {{ ------
  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        registerUser: sl(),
        logoutUser: sl(),
        checkLoginStatus: sl(),
      ));

  // Register Use Cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => CheckLoginStatus(sl()));

  // Register Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Register Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  // Register Local Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(sharedPreferences: sl()),
  );

  /// AuthBloc ------ }}

  /// TaskBloc {{ ------
  sl.registerFactory(() => TaskBloc(
        createTask: sl(),
        updateTask: sl(),
        deleteTask: sl(),
        getTasks: sl(),
      ));

  // Register Use Cases
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));

  // Register Repositories
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(remoteDataSource: sl()),
  );

  // Register Data Sources
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSource(),
  );

  /// TaskBloc ------ }}

  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
