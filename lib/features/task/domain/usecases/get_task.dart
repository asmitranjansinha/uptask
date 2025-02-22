// features/task/domain/usecases/get_tasks.dart
import 'package:uptask/features/task/domain/entities/task_entity.dart';
import 'package:uptask/features/task/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<TaskEntity>> call() async {
    return await repository.getTasks();
  }
}
