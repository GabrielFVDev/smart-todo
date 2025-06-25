import 'package:bank/controllers/task_controller.dart';
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
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tarefas',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Organize seu dia',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: ListenableBuilder(
                  listenable: _controller,
                  builder: (context, child) {
                    if (_controller.tasks.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 48,
                              color: Colors.blue.shade400,
                            ),
                          ),
                          SizedBox(height: 32),
                          Text(
                            'Nenhuma tarefa ainda',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Comece organizando suas tarefas. Toque\nno botão + para adicionar sua primeira\ntarefa.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 32),
                          TextButton(
                            onPressed: () => context.push('/add'),
                            child: Text(
                              'Adicionar primeira tarefa',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.shade600,
                              ),
                            ),
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
                            onUpdateTask: _controller.updateTaskTitle,
                          ),

                          // Seção de tarefas normais
                          TaskSectionWidget(
                            title: 'Tarefas',
                            icon: Icons.task_alt,
                            tasks: _controller.regularTasks,
                            onDelete: _controller.removeTask,
                            onUpdateTask: _controller.updateTaskTitle,
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
        backgroundColor: Colors.blue.shade600,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
