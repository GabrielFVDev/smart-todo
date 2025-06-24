import 'package:bank/controller/category_controller.dart';
import 'package:bank/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _taskController = TextEditingController();
  final TaskController _controller = TaskController();
  final CategoryController _categoryController = CategoryController();

  bool _isFavorite = false;

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Tarefa'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Digite a nova tarefa!',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Opção de favorito
            SwitchListTile(
              title: Row(
                children: [
                  Icon(
                    _isFavorite ? Icons.star : Icons.star_border,
                    color: _isFavorite ? Colors.amber : null,
                  ),
                  SizedBox(width: 8),
                  Text('Adicionar aos favoritos'),
                ],
              ),
              value: _isFavorite,
              onChanged: (value) {
                setState(() {
                  _isFavorite = value;
                });
              },
            ),

            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final text = _taskController.text.trim();
                if (text.isNotEmpty) {
                  // Escolhe a categoria com base no estado do switch
                  final category =
                      _isFavorite
                          ? _categoryController.categories.firstWhere(
                            (c) => c.name == 'Favoritos',
                          )
                          : _categoryController.defaultCategory;

                  _controller.addTask(text, category: category);
                  context.pop();
                }
              },
              child: Text('Adicionar'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
