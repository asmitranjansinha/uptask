import 'package:uptask/features/auth/domain/entities/user_entity.dart';
import 'package:uptask/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<UserEntity> call(String email, String password, String name) async {
    return await repository.register(email, password, name);
  }
}
