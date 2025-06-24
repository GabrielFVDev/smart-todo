import 'package:bank/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TaskController _controller = TaskController();

  @override
  void dispose() {
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
            Text('Bem vindo!'),
            SizedBox(height: 12),
            Text('Pronto para finalizar as tarefas?'),
            SizedBox(height: 24),
            Expanded(
              child: ListenableBuilder(
                listenable: _controller,
                builder: (context, child) {
                  if (_controller.tasks.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nenhuma tarefa adicionada, deseja adicionar?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextButton(
                          onPressed: () => context.push('/add'),
                          child: Text('Clique aqui para adicionar'),
                        ),
                      ],
                    );
                  }

                  // Se houver tarefas, exibe a lista
                  return ListView.builder(
                    itemCount: _controller.tasks.length,
                    itemBuilder: (context, index) {
                      final task = _controller.tasks[index];
                      return ListTile(
                        title: Text(task.title),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _controller.removeTask(task),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
