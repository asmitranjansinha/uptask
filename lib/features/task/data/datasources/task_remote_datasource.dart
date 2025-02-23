import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uptask/features/task/data/models/task_model.dart';

class TaskRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTask(String uid, String title, String description,
      DateTime dueDate, String priority) async {
    final taskRef =
        _firestore.collection('users').doc(uid).collection('tasks').doc();
    final taskWithId = TaskModel(
      id: taskRef.id,
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
      isCompleted: false,
    );

    await taskRef.set(taskWithId.toJson());
  }

  Future<void> updateTask(String uid, TaskModel task) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(task.id)
        .update(task.toJson());
  }

  Future<void> deleteTask(String uid, String taskId) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  Future<List<TaskModel>> getTasks(String uid) async {
    final querySnapshot =
        await _firestore.collection('users').doc(uid).collection('tasks').get();

    return querySnapshot.docs
        .map((doc) => TaskModel.fromJson(doc.data()))
        .toList();
  }
}
