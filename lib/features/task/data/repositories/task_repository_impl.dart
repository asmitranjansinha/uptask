// features/task/data/repositories/task_repository_impl.dart
import 'package:uptask/features/task/domain/entities/task_entity.dart';
import 'package:uptask/features/task/domain/repositories/task_repository.dart';
import 'package:uptask/features/task/data/datasources/task_remote_datasource.dart';
import 'package:uptask/features/task/data/models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createTask(TaskEntity task) async {
    await remoteDataSource.createTask(TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      priority: task.priority,
      isCompleted: task.isCompleted,
    ));
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await remoteDataSource.updateTask(TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      priority: task.priority,
      isCompleted: task.isCompleted,
    ));
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await remoteDataSource.deleteTask(taskId);
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    return await remoteDataSource.getTasks();
  }
}
