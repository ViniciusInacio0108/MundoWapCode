import 'package:flutter/material.dart';

import 'package:mundo_wap_teste/data/repositories/task/task_repository_local.dart';
import 'package:mundo_wap_teste/domain/task.dart';
import 'package:mundo_wap_teste/utils/response_result.dart';

class TasksViewModel extends ChangeNotifier {
  final TaskLocalRepository localTaskRepo;

  TasksViewModel({
    required this.localTaskRepo,
  });

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<List<Task>> _fetchTasksLocal() async {
    final result = await localTaskRepo.getTasks();

    switch (result) {
      case Ok<List<Task>>():
        return result.value;
      default:
        return [];
    }
  }

  Future<void> _saveTasksLocally(List<Task> tasks) async {
    final result = await localTaskRepo.saveTasks(tasks);

    switch (result) {
      case Ok<bool>():
        break;
      case Error<bool>():
        return;
    }
  }

  Future<void> setTasks(List<Task> loginTasks) async {
    final localTasks = await _fetchTasksLocal();

    if (localTasks.isEmpty) {
      _tasks = loginTasks;
      await _saveTasksLocally(tasks);
      notifyListeners();
      return;
    }

    _tasks = localTasks;
    notifyListeners();
  }
}
