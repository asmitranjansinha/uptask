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

    add(GetTasksEvent());
  }

  Future<void> _onCreateTaskEvent(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    final currentState = state; // Capture current state

    if (currentState is TaskLoaded) {
      emit(TaskLoadingWithData(currentState.tasks)); // Preserve existing tasks
    } else {
      emit(TaskLoading()); // Fallback if no tasks exist
    }

    try {
      await createTask(
        event.title,
        event.description,
        event.dueDate,
        event.priority,
      );
      final tasks = await getTasks();
      emit(TaskLoaded(tasks)); // Emit updated list
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onUpdateTaskEvent(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    final currentState = state; // Capture current state

    if (currentState is TaskLoaded) {
      emit(TaskLoadingWithData(currentState.tasks)); // Preserve existing tasks
    } else {
      emit(TaskLoading()); // Fallback if no tasks exist
    }
    try {
      await updateTask(event.task);
      final tasks = await getTasks();
      emit(TaskLoaded(tasks)); // Emit updated list
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    final currentState = state; // Capture current state

    if (currentState is TaskLoaded) {
      emit(TaskLoadingWithData(currentState.tasks)); // Preserve existing tasks
    } else {
      emit(TaskLoading()); // Fallback if no tasks exist
    }
    try {
      await deleteTask(event.taskId);
      final tasks = await getTasks();
      emit(TaskLoaded(tasks)); // Emit updated list
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
