import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<void> createTask(
      String title, String description, DateTime dueDate, String priority);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String taskId);
  Future<List<TaskEntity>> getTasks();
}
