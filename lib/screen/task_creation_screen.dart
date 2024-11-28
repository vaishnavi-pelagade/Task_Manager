import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/bloc/task_bloc.dart';
import 'package:taskmanager/bloc/task_event_bloc.dart';
import 'package:taskmanager/data/task_model.dart';

class TaskCreationScreen extends StatefulWidget {
  final Task? task;

  const TaskCreationScreen({Key? key, this.task}) : super(key: key);

  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;
  String _status = 'Pending';

  @override
  void initState() {
    super.initState();

    // Initialize the controllers and values with the task data if provided
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
    _status = widget.task?.status ?? 'Pending';
    _dueDate = widget.task?.dueDate.isNotEmpty == true
        ? DateTime.parse(widget.task!.dueDate)
        : null;
  }

  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color.fromARGB(255, 147, 222, 255);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Create Task' : 'Update Task'),
        backgroundColor: themeColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Task Details', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Title is required'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _dueDate == null
                            ? 'No due date selected'
                            : 'Selected Due Date: ${_dueDate!.toLocal()}'.split(' ')[0],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _selectDate,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _status,
                  items: const [
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final task = Task(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueDate: _dueDate?.toIso8601String() ?? '',
                          status: _status,
                          id: widget.task?.id, // Maintain the same ID if updating
                        );

                        if (widget.task == null) {
                          // If task is new, add the task
                          context.read<TaskBloc>().add(AddTask(task));
                        } else {
                          // If task is being updated, update the task
                          context.read<TaskBloc>().add(UpdateTask(task));
                        }

                        // Navigate back to Task List Screen after adding or updating task
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(widget.task == null ? 'Save Task' : 'Update Task'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
