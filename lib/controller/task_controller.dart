import 'package:flutter/material.dart';

class TaskController extends ChangeNotifier {
  static final TaskController _instance = TaskController._internal();

  factory TaskController() {
    return _instance;
  }

  TaskController._internal();

  final List<String> _tasks = [];

  List<String> get tasks => List.unmodifiable(_tasks);

  void addTask(String task) {
    if (task.isNotEmpty) {
      _tasks.add(task);
      print("Tarefa adicionada: $task. Total: ${_tasks.length}");
      notifyListeners();
    }
  }

  void removeTask(String task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }
}
