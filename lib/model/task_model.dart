import 'package:bank/model/category_model.dart';

class TaskModel {
  int id;
  String title;
  CategoryModel category;
  bool favorite;
  bool completed;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    this.favorite = false,
    this.completed = false,
  });
}
