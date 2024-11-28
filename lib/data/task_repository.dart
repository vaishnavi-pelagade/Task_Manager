import 'package:taskmanager/data/task_model.dart';

class TaskRepository {

  final List<Task> _tasks = [
    Task(id: 1, title: 'Task 1', description: 'Description 1', dueDate: '2024-12-01', status: 'Pending'),
    Task(id: 2, title: 'Task 2', description: 'Description 2', dueDate: '2024-12-02', status: 'Completed'),
  ];


  Future<List<Task>> getAllTasks() async {
   
    await Future.delayed(Duration(seconds: 1)); 
    return _tasks;
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    await Future.delayed(Duration(seconds: 1)); 
    _tasks.add(task);
    print('Task added: ${task.title}');
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    await Future.delayed(Duration(seconds: 1)); 
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      print('Task updated: ${task.title}');
    } else {
      throw Exception('Task not found for update');
    }
  }


  Future<void> deleteTask(int id) async {
    await Future.delayed(Duration(seconds: 1));  
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks.removeAt(index);
      print('Task deleted with id: $id');
    } else {
      throw Exception('Task not found for deletion');
    }
  }
}
