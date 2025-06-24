import 'package:bank/model/task_model.dart';
import 'package:flutter/material.dart';

class TaskController extends ChangeNotifier {
  static final TaskController _instance = TaskController._internal();

  factory TaskController() {
    return _instance;
  }

  TaskController._internal();

  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => List.unmodifiable(_tasks);

  void addTask(String title) {
    if (title.trim().isNotEmpty) {
      final task = TaskModel(
        id: _tasks.length + 1,
        title: title.trim(),
        category: 'Geral', // Categoria padrão
      );
      _tasks.add(task);
      print('Tarefa adicionada: ${task.title}. Total: ${_tasks.length}');
      notifyListeners();
    }
  }

  void removeTask(TaskModel task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }
}
