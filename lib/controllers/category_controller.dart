import 'package:bank/models/category_model.dart';
import 'package:bank/repositories/storage_repository.dart';
import 'package:flutter/foundation.dart';

class CategoryController extends ChangeNotifier {
  static final CategoryController _instance = CategoryController._internal();
  final StorageRepository _storage = StorageRepository();
  final String _storageKey = 'categories_data';

  final List<CategoryModel> _categories = [];

  factory CategoryController() {
    return _instance;
  }

  CategoryController._internal() {
    _init();
  }

  Future _init() async {
    await _loadCategories();
    if (_categories.isEmpty) {
      _initDefaultCategories();
      await _saveCategories();
    }
  }

  List<CategoryModel> get categories => List.unmodifiable(_categories);

  CategoryModel get defaultCategory {
    try {
      return _categories.firstWhere((c) => c.isDefault);
    } catch (_) {
      return _categories.first;
    }
  }

  CategoryModel? getCategoryById(int id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  CategoryModel? getCategoryByName(String name) {
    try {
      return _categories.firstWhere((c) => c.name == name);
    } catch (_) {
      return null;
    }
  }

  void _initDefaultCategories() {
    _categories.add(CategoryModel(id: 1, name: 'Geral', isDefault: true));
    _categories.add(CategoryModel(id: 2, name: 'Favoritos', icon: 'star'));
  }

  Future _loadCategories() async {
    final data = await _storage.loadData(_storageKey);
    if (data.isNotEmpty) {
      _categories.clear();
      for (final item in data) {
        _categories.add(CategoryModel.fromJson(item));
      }
      notifyListeners();
    }
  }

  Future _saveCategories() async {
    final data = _categories.map((c) => c.toJson()).toList();
    await _storage.saveData(_storageKey, data);
    notifyListeners();
  }

  Future addCategory(String name, {String icon = 'folder'}) async {
    if (name.trim().isEmpty) return;

    final newId =
        _categories.isEmpty
            ? 1
            : _categories.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1;

    _categories.add(
      CategoryModel(
        id: newId,
        name: name.trim(),
        icon: icon,
      ),
    );

    await _saveCategories();
  }

  Future removeCategory(int id) async {
    final category = getCategoryById(id);
    if (category == null || category.isDefault) return;

    _categories.removeWhere((c) => c.id == id);
    await _saveCategories();
  }

  Future resetToDefaults() async {
    _categories.clear();
    _initDefaultCategories();
    await _saveCategories();
  }
}
