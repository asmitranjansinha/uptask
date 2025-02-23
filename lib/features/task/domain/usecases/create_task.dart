import 'package:uptask/features/task/domain/repositories/task_repository.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<void> call(String title, String description, DateTime dueDate,
      String priority) async {
    return await repository.createTask(title, description, dueDate, priority);
  }
}
