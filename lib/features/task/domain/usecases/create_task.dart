import 'package:uptask/features/task/domain/entities/task_entity.dart';
import 'package:uptask/features/task/domain/repositories/task_repository.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<void> call(TaskEntity task) async {
    return await repository.createTask(task);
  }
}
