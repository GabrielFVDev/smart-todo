import 'package:bank/model/task_model.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final Function(TaskModel) onDelete;
  final Function(TaskModel) onToggleFavorite;
  final bool isFavorite;
  const TaskItemWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(task.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : null,
              ),
              onPressed: () => onToggleFavorite(task),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete(task),
            ),
          ],
        ),
      ),
    );
  }
}
