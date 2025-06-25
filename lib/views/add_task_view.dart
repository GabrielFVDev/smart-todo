import 'package:bank/controllers/category_controller.dart';
import 'package:bank/controllers/task_controller.dart';
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

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Nova Tarefa',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text('Titulo da tarefa'),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 24),
                      InkWell(
                        onTap: () => _controller.toggleCreatingFavorite(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Favoritar?'),
                            SizedBox(width: 16),
                            Icon(
                              Icons.favorite,
                              color:
                                  _controller.isCreatingFavorite
                                      ? Colors.red
                                      : Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 40,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.pop(),
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final text = _taskController.text.trim();
                        if (text.isNotEmpty) {
                          final category =
                              _controller.isCreatingFavorite
                                  ? _categoryController.categories.firstWhere(
                                    (c) => c.name == 'Favoritos',
                                  )
                                  : _categoryController.defaultCategory;

                          _controller.addTask(text, category: category);
                          context.pop();
                        }
                      },
                      child: Text('Criar tarefa'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
