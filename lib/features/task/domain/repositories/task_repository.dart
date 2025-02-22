import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String taskId);
  Future<List<TaskEntity>> getTasks();
}
