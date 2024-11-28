import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/data/task_repository.dart';
import 'package:taskmanager/bloc/task_event_bloc.dart';
import 'package:taskmanager/bloc/task_state_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await repository.getAllTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError('Failed to load tasks.'));
      }
    });

    // Handle adding a task
    on<AddTask>((event, emit) async {
      try {
        await repository.addTask(event.task);
        add(LoadTasks());  // Reload tasks after adding
      } catch (e) {
        emit(TaskError('Failed to add task'));
      }
    });

    // Handle updating a task
    on<UpdateTask>((event, emit) async {
      try {
        await repository.updateTask(event.task);
        add(LoadTasks());  // Reload tasks after updating
      } catch (e) {
        emit(TaskError('Failed to update task.'));
      }
    });

    // Handle deleting a task
    on<DeleteTask>((event, emit) async {
      try {
        await repository.deleteTask(event.id);
        add(LoadTasks());  // Reload tasks after deletion
      } catch (e) {
        emit(TaskError('Failed to delete task.'));
      }
    });
  }
}
