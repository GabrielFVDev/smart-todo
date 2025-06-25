import 'package:bank/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final Function(TaskModel) onDelete;
  final Function(TaskModel) onToggleFavorite;
  final Function(TaskModel, String) onUpdateTask;
  final bool isFavorite;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.onUpdateTask,
    required this.isFavorite,
  });

  void _showEditDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController(
      text: task.title,
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Editar Tarefa'),
            content: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Título da Tarefa',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newTitle = textController.text.trim();
                  if (newTitle.isNotEmpty) {
                    onUpdateTask(task, newTitle);
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
    );
  }

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
              icon: Icon(Icons.edit),
              onPressed: () => _showEditDialog(context),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red[300]),
              onPressed: () => onDelete(task),
            ),
          ],
        ),
      ),
    );
  }
}
