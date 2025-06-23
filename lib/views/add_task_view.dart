import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

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
              decoration: InputDecoration(
                labelText: 'Digite a nova tarefa!',
                border: OutlineInputBorder(),
                icon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
