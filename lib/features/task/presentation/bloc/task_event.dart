import 'package:equatable/equatable.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;

  const CreateTaskEvent(
    this.title,
    this.description,
    this.dueDate,
    this.priority,
  );

  @override
  List<Object> get props => [title, description, dueDate, priority];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class GetTasksEvent extends TaskEvent {}
