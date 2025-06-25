import 'package:bank/models/category_model.dart';
import 'package:uuid/uuid.dart';

class TaskModel {
  final String id;
  final String title;
  final CategoryModel category;
  final bool completed;

  static final _uuid = Uuid();

  TaskModel({
    String? id,
    required this.title,
    required this.category,
    this.completed = false,
  }) : id = id ?? _uuid.v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categoryId': category.id,
      'completed': completed,
    };
  }

  factory TaskModel.fromJson(
    Map<String, dynamic> json,
    List<CategoryModel> categories,
  ) {
    final categoryId = json['categoryId'] as int? ?? 1;

    final category = categories.firstWhere(
      (c) => c.id == categoryId,
      orElse:
          () => categories.firstWhere(
            (c) => c.isDefault,
            orElse: () => categories.first,
          ),
    );

    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: category,
      completed: json['completed'] as bool? ?? false,
    );
  }

  // Cria uma cópia da tarefa com valores potencialmente diferentes
  TaskModel copyWith({
    String? id,
    String? title,
    CategoryModel? category,
    bool? completed,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      completed: completed ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
