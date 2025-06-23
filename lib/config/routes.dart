import 'package:bank/views/add_task_view.dart';
import 'package:bank/views/home_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      name: 'add',
      path: '/add',
      builder: (context, state) => AddTaskView(),
    ),
  ],
);
