import 'package:bank/controller/task_controller.dart';
import 'package:bank/views/widgets/task_section_widget.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Seção de favoritos
                          TaskSectionWidget(
                            title: 'Favoritas',
                            icon: Icons.star,
                            tasks: _controller.favoriteTasks,
                            onDelete: _controller.removeTask,
                            onToggleFavorite: _controller.toggleFavorite,
                          ),

                          // Seção de tarefas normais
                          TaskSectionWidget(
                            title: 'Tarefas',
                            icon: Icons.task_alt,
                            tasks: _controller.regularTasks,
                            onDelete: _controller.removeTask,
                            onToggleFavorite: _controller.toggleFavorite,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: Icon(Icons.add_task),
      ),
    );
  }
}
