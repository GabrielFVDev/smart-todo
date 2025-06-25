import 'package:bank/controllers/category_controller.dart';
import 'package:bank/models/category_model.dart';
import 'package:bank/models/task_model.dart';
import 'package:bank/repositories/storage_repository.dart';
import 'package:flutter/foundation.dart';

class TaskController extends ChangeNotifier {
  static final TaskController _instance = TaskController._internal();
  final StorageRepository _storage = StorageRepository();
  final CategoryController _categoryController = CategoryController();
  final String _storageKey = 'tasks_data';

  // Lista de tarefas
  final List<TaskModel> _tasks = [];

  // Singleton
  factory TaskController() {
    return _instance;
  }

  TaskController._internal() {
    _loadTasks();
  }

  // Getters
  List<TaskModel> get tasks => List.unmodifiable(_tasks);

  List<TaskModel> getTasksByCategory(CategoryModel category) {
    return _tasks.where((task) => task.category.id == category.id).toList();
  }

  List<TaskModel> get favoriteTasks {
    final favoriteCategory = _categoryController.getCategoryByName('Favoritos');
    if (favoriteCategory == null) return [];
    return getTasksByCategory(favoriteCategory);
  }

  List<TaskModel> get regularTasks {
    return getTasksByCategory(_categoryController.defaultCategory);
  }

  // Carregar tarefas
  Future _loadTasks() async {
    try {
      final data = await _storage.loadData(_storageKey);

      if (data.isNotEmpty) {
        _tasks.clear();

        // Certifique-se de que as categorias foram carregadas
        await Future.delayed(Duration(milliseconds: 100));

        for (final item in data) {
          _tasks.add(TaskModel.fromJson(item, _categoryController.categories));
        }
        notifyListeners();
      }
    } catch (e) {
      print('Erro ao carregar tarefas: $e');
    }
  }

  // Salvar tarefas
  Future _saveTasks() async {
    try {
      final data = _tasks.map((t) => t.toJson()).toList();
      await _storage.saveData(_storageKey, data);
    } catch (e) {
      print('Erro ao salvar tarefas: $e');
    }
  }

  // Adicionar tarefa
  Future addTask(String title, {CategoryModel? category}) async {
    if (title.trim().isEmpty) return;

    _tasks.add(
      TaskModel(
        title: title.trim(),
        category: category ?? _categoryController.defaultCategory,
      ),
    );

    await _saveTasks();
    notifyListeners();
  }

  // Atualizar tarefa
  Future<void> updateTask(
    TaskModel task, {
    String? title,
    CategoryModel? category,
    bool? completed,
  }) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index == -1) return;

    _tasks[index] = task.copyWith(
      title: title,
      category: category,
      completed: completed,
    );

    await _saveTasks();
    notifyListeners();
  }

  // Atualizar título da tarefa (método simplificado para a UI)
  Future<void> updateTaskTitle(TaskModel task, String title) async {
    await updateTask(task, title: title);
  }

  // Alternar entre favorito e não favorito
  Future toggleFavorite(TaskModel task) async {
    final favoriteCategory = _categoryController.getCategoryByName('Favoritos');
    if (favoriteCategory == null) return;

    final defaultCategory = _categoryController.defaultCategory;
    final newCategory =
        task.category.id == favoriteCategory.id
            ? defaultCategory
            : favoriteCategory;

    await updateTask(task, category: newCategory);
  }

  // Alternar status de conclusão da tarefa
  Future toggleCompleted(TaskModel task) async {
    await updateTask(task, completed: !task.completed);
  }

  // Remover tarefa
  Future removeTask(TaskModel task) async {
    _tasks.removeWhere((t) => t.id == task.id);
    await _saveTasks();
    notifyListeners();
  }

  // Limpar todas as tarefas
  Future clearTasks() async {
    _tasks.clear();
    await _saveTasks();
    notifyListeners();
  }
}
