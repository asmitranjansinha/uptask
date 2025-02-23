import 'package:equatable/equatable.dart';
import 'package:uptask/features/task/domain/entities/task_entity.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskCreated extends TaskState {}

class TaskUpdated extends TaskState {}

class TaskDeleted extends TaskState {}

class TaskLoadingWithData extends TaskState {
  final List<TaskEntity> tasks;
  const TaskLoadingWithData(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskFailure extends TaskState {
  final String error;

  const TaskFailure(this.error);

  @override
  List<Object> get props => [error];
}
