import 'package:flutter/material.dart';
import 'package:bank/model/category_model.dart';

class CategoryController extends ChangeNotifier {
  static final CategoryController _instance = CategoryController._internal();

  factory CategoryController() {
    return _instance;
  }

  CategoryController._internal() {
    _initDefaultCategories();
  }

  final List<CategoryModel> _categories = [];

  void _initDefaultCategories() {
    _categories.add(CategoryModel(id: 1, name: 'Geral', isDefault: true));
    _categories.add(
      CategoryModel(
        id: 2,
        name: 'Favoritos',
      ),
    );
  }

  List<CategoryModel> get categories => List.unmodifiable(_categories);

  CategoryModel get defaultCategory => _categories.firstWhere(
    (cat) => cat.isDefault,
    orElse: () => _categories.first,
  );

  void addCategory(String name, {String icon = 'folder'}) {
    if (name.trim().isNotEmpty) {
      final newId =
          _categories.isEmpty
              ? 1
              : (_categories.map((e) => e.id).reduce((a, b) => a > b ? a : b) +
                  1);

      _categories.add(
        CategoryModel(
          id: newId,
          name: name.trim(),
        ),
      );

      notifyListeners();
    }
  }
}
