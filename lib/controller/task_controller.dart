import 'package:bank/controller/category_controller.dart';
import 'package:bank/model/category_model.dart';
import 'package:bank/model/task_model.dart';
import 'package:flutter/material.dart';

class TaskController extends ChangeNotifier {
  static final TaskController _instance = TaskController._internal();
  final CategoryController _categoryController = CategoryController();

  factory TaskController() {
    return _instance;
  }

  TaskController._internal();

  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => List.unmodifiable(_tasks);

  void addTask(String title, {CategoryModel? category}) {
    if (title.trim().isNotEmpty) {
      final task = TaskModel(
        id: _tasks.length + 1,
        title: title.trim(),
        category: category ?? _categoryController.defaultCategory,
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

  List<TaskModel> getTasksByCategory(CategoryModel category) {
    return _tasks.where((task) => task.category.id == category.id).toList();
  }
}
