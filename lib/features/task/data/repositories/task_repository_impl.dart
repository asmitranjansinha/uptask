// features/task/data/repositories/task_repository_impl.dart
import 'package:uptask/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';
import 'package:uptask/features/task/domain/repositories/task_repository.dart';
import 'package:uptask/features/task/data/datasources/task_remote_datasource.dart';
import 'package:uptask/features/task/data/models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<void> createTask(String title, String description, DateTime dueDate,
      String priority) async {
    final userData = await authLocalDataSource.getUserData();
    final uid = userData[0];
    await remoteDataSource.createTask(
      uid,
      title,
      description,
      dueDate,
      priority,
    );
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final userData = await authLocalDataSource.getUserData();
    final uid = userData[0];
    await remoteDataSource.updateTask(
        uid,
        TaskModel(
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
    final userData = await authLocalDataSource.getUserData();
    final uid = userData[0];
    await remoteDataSource.deleteTask(uid, taskId);
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    final userData = await authLocalDataSource.getUserData();
    final uid = userData[0];
    return await remoteDataSource.getTasks(uid);
  }
}
