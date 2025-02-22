// features/auth/data/repositories/auth_repository_impl.dart
import 'package:uptask/features/auth/domain/entities/user_entity.dart';
import 'package:uptask/features/auth/domain/repositories/auth_repository.dart';
import 'package:uptask/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<UserEntity> register(
      String email, String password, String name) async {
    return await remoteDataSource.register(email, password, name);
  }

  @override
  Future<void> logout() async {
    return await remoteDataSource.logout();
  }
}
