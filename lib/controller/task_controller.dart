import 'package:flutter/material.dart';

class TaskController extends ChangeNotifier {
  final List<String> _tasks = [];

  List<String> get tasks => List.unmodifiable(_tasks);

  void addTask(String task) {
    if (task.isNotEmpty) {
      _tasks.add(task);
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
