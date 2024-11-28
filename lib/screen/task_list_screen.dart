import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/bloc/task_bloc.dart';
import 'package:taskmanager/bloc/task_state_bloc.dart';
import 'package:taskmanager/screen/task_creation_screen.dart';
import 'package:taskmanager/screen/task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Task Manager',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 147, 222, 255),
          centerTitle: true,
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              final tasks = state.tasks;
              if (tasks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.task_alt, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 20),
                      const Text(
                        'No tasks available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 147, 222, 255),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<TaskBloc>(context),
                                child: const TaskCreationScreen(),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Add Task',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: tasks.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Due: ${task.dueDate}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Icon(
                        task.isCompleted ? Icons.check_circle : Icons.pending,
                        color: task.isCompleted ? Colors.green : Colors.orange,
                        size: 28,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TaskDetailScreen(task: task),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Failed to load tasks'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 147, 222, 255),
          tooltip: 'Add Task',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<TaskBloc>(context),
                  child: const TaskCreationScreen(),
                ),
              ),
            );
          },
          child: const Icon(Icons.add, size: 28, color: Colors.white),
        ),
      ),
    );
  }
}
