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

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Digite a nova tarefa!',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final text = _taskController.text.trim();
                if (text.isNotEmpty) {
                  _controller.addTask(text);
                  context.pop();
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
