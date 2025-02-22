// features/task/data/datasources/task_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uptask/features/task/data/models/task_model.dart';

class TaskRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTask(TaskModel task) async {
    await _firestore.collection('tasks').doc(task.id).set(task.toJson());
  }

  Future<void> updateTask(TaskModel task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }

  Future<List<TaskModel>> getTasks() async {
    final querySnapshot = await _firestore.collection('tasks').get();
    return querySnapshot.docs
        .map((doc) => TaskModel.fromJson(doc.data()))
        .toList();
  }
}
