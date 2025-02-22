// features/auth/data/repositories/auth_repository_impl.dart
import 'package:uptask/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:uptask/features/auth/domain/entities/user_entity.dart';
import 'package:uptask/features/auth/domain/repositories/auth_repository.dart';
import 'package:uptask/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await remoteDataSource.login(email, password);
    await localDataSource.saveLoginStatus(true);
    return user;
  }

  @override
  Future<UserEntity> register(
      String email, String password, String name) async {
    final user = await remoteDataSource.register(email, password, name);
    await localDataSource.saveLoginStatus(true);
    return user;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.logout();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.getLoginStatus();
  }
}
