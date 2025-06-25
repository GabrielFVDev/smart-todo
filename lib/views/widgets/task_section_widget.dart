import 'package:bank/models/task_model.dart';
import 'package:bank/views/widgets/task_item_widget.dart';
import 'package:flutter/material.dart';

class TaskSectionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<TaskModel> tasks;
  final Function(TaskModel) onDelete;
  final Function(TaskModel) onToggleFavorite;
  final Function(TaskModel, String) onUpdateTask;

  const TaskSectionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.tasks,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.onUpdateTask,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabeçalho da seção
        Row(
          children: [
            Icon(icon, size: 22),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Lista de tarefas ou mensagem vazia
        tasks.isEmpty
            ? Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
              child: Text(
                'Nenhuma tarefa nesta categoria',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
            : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  task: tasks[index],
                  onDelete: onDelete,
                  onToggleFavorite: onToggleFavorite,
                  onUpdateTask: onUpdateTask,
                  isFavorite: title == 'Favoritas',
                );
              },
            ),
      ],
    );
  }
}
