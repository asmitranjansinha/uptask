// core/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:uptask/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:uptask/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:uptask/features/auth/domain/repositories/auth_repository.dart';
import 'package:uptask/features/auth/domain/usecases/login_user.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_bloc.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Register BLoCs
  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        registerUser: sl(),
        logoutUser: sl(),
      ));

  // Register Use Cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  // Register Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Register Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );
}
