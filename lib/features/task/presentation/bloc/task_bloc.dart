// features/task/presentation/bloc/task_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptask/features/task/domain/usecases/create_task.dart';
import 'package:uptask/features/task/domain/usecases/delete_task.dart';
import 'package:uptask/features/task/domain/usecases/get_task.dart';
import 'package:uptask/features/task/domain/usecases/update_task.dart';
import 'package:uptask/features/task/presentation/bloc/task_event.dart';
import 'package:uptask/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final GetTasks getTasks;

  TaskBloc({
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.getTasks,
  }) : super(TaskInitial()) {
    on<CreateTaskEvent>(_onCreateTaskEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
    on<GetTasksEvent>(_onGetTasksEvent);
  }

  Future<void> _onCreateTaskEvent(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await createTask(event.task);
      emit(TaskCreated());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onUpdateTaskEvent(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await updateTask(event.task);
      emit(TaskUpdated());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await deleteTask(event.taskId);
      emit(TaskDeleted());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onGetTasksEvent(
      GetTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }
}
