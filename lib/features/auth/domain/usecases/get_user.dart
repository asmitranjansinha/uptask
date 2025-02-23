import 'package:uptask/features/auth/domain/entities/user_entity.dart';
import 'package:uptask/features/auth/domain/repositories/auth_repository.dart';

class GetUser {
  final AuthRepository repository;

  GetUser(this.repository);

  Future<UserEntity> call() async {
    return await repository.getUser();
  }
}
