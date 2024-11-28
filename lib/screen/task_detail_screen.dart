import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/bloc/task_bloc.dart';
import 'package:taskmanager/bloc/task_event_bloc.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/screen/task_creation_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color.fromARGB(255, 147, 222, 255);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TaskCreationScreen(task: task),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Task'),
                  content:
                      const Text('Are you sure you want to delete this task?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<TaskBloc>().add(DeleteTask(task.id!));
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(height: 30, thickness: 1.5),
                  ListTile(
                    leading:
                        const Icon(Icons.description, color: Colors.black54),
                    title: const Text('Description'),
                    subtitle: Text(
                      task.description.isEmpty
                          ? 'No description provided'
                          : task.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.calendar_today, color: Colors.black54),
                    title: const Text('Due Date'),
                    subtitle: Text(
                      task.dueDate,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      task.status == 'Completed'
                          ? Icons.check_circle
                          : Icons.pending,
                      color: task.status == 'Completed'
                          ? Colors.green
                          : Colors.orange,
                    ),
                    title: const Text('Status'),
                    subtitle: Text(
                      task.status,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TaskCreationScreen(task: task),
                          ),
                        );
                      },
                      child: const Text(
                        'Edit Task',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
