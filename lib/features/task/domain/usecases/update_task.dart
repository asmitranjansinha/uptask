// features/task/domain/usecases/update_task.dart
import 'package:uptask/features/task/domain/entities/task_entity.dart';
import 'package:uptask/features/task/domain/repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(TaskEntity task) async {
    return await repository.updateTask(task);
  }
}
