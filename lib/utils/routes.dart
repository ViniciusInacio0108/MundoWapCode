import 'package:flutter/material.dart';
import 'package:mundo_wap_teste/domain/task.dart';
import 'package:mundo_wap_teste/ui/features.dart';

class MyAppRoutes {
  static const String LOGIN_PAGE = "/";
  static const String TASKS_PAGE = "/tasks";
  static const String DETAIL_TASK_PAGE = "/detail-task";

  Map<String, Widget Function(BuildContext)> routes = {
    LOGIN_PAGE: (_) => const LoginPage(),
    TASKS_PAGE: (_) => const ListTasksPage(),
    DETAIL_TASK_PAGE: (context) {
      final argument = ModalRoute.of(context)?.settings.arguments as Task;

      return DetailTaskPage(
        task: argument,
      );
    },
  };
}
