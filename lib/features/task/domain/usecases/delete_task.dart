// features/task/domain/usecases/delete_task.dart
import 'package:uptask/features/task/domain/repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(String taskId) async {
    return await repository.deleteTask(taskId);
  }
}
