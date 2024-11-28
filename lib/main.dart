import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/bloc/task_bloc.dart';
import 'package:taskmanager/bloc/task_event_bloc.dart';
import 'package:taskmanager/data/task_repository.dart';
import 'package:taskmanager/screen/task_list_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (_) => TaskBloc(TaskRepository())..add(LoadTasks()), // Load tasks initially
        ),
        // Add more providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
