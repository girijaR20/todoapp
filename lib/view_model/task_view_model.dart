import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/model/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _sharedTasks = [];
  List<Task> get tasks => _tasks;
  List<Task> get sharedTasks => _sharedTasks;
  final TaskRepository _repository = TaskRepository();
  String? owner;

  TaskViewModel({required this.owner}) {
    _repository.getTasks(owner).listen((tasks) {
      _tasks = tasks;
      notifyListeners();
    });
    _repository.getSharedTasks(owner).listen((tasks) {
      _sharedTasks = tasks;
      notifyListeners();
    });
  }

  Future<void> addTask(Task task) async {
    await _repository.addTask(task);
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
  }

  Future<void> deleteTask(String? taskId) async {
    await _repository.deleteTask(taskId);
  }

}