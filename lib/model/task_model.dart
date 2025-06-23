class TaskModel {
  int id;
  String title;
  String category;
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
