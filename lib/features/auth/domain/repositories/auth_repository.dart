// features/auth/domain/repositories/auth_repository.dart
import 'package:uptask/features/auth/domain/entities/user_entitiy.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String email, String password, String name);
  Future<void> logout();
}
