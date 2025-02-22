// features/auth/domain/usecases/login_user.dart
import 'package:uptask/features/auth/domain/entities/user_entitiy.dart';
import 'package:uptask/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<UserEntity> call(String email, String password) async {
    return await repository.login(email, password);
  }
}

// features/auth/domain/usecases/register_user.dart
class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<UserEntity> call(String email, String password, String name) async {
    return await repository.register(email, password, name);
  }
}

// features/auth/domain/usecases/logout_user.dart
class LogoutUser {
  final AuthRepository repository;

  LogoutUser(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}
