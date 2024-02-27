import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/view_model/task_view_model.dart';
import 'package:todoapp/view_model/user_view_model.dart';

class TaskForm extends StatefulWidget {
  final bool isEdit;
  final Task? task;
  const TaskForm({super.key, this.isEdit = false,  this.task});
  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<TaskForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Task? taskToEdit = widget.task;
    final userViewModel = Provider.of<UserViewModel>(context);
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    String? userId = userViewModel.currentUser?.uid;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Create Your Task',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                String title = _titleController.text;
                String description = _descriptionController.text;
                if (title.isNotEmpty && description.isNotEmpty) {
                  if (widget.isEdit) {
                   taskToEdit?.title = title;
                   taskToEdit?.description = description;
                   taskViewModel.updateTask(taskToEdit!);
                  } else {
                    taskViewModel.addTask(Task(title: title,
                        description: description,
                        createdBy: userId,
                        owner: userId));
                  }
                  Navigator.pop(context); // Close the bottom sheet
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
              ),
              child: const Text('Add Task'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}