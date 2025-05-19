import 'package:flutter/material.dart';
import 'package:mundo_wap_teste/data/repositories/task/task_repository_local.dart';
import 'package:mundo_wap_teste/domain/task.dart';
import 'package:mundo_wap_teste/utils/response_result.dart';

class DetailTaskViewModel extends ChangeNotifier {
  final TaskLocalRepository taskLocalRepo;

  DetailTaskViewModel({required this.taskLocalRepo});

  Future<ResponseResult<Task>> registerTask(Task updatedTask) async {
    final result = await taskLocalRepo.updateTask(updatedTask);

    switch (result) {
      case Ok<Task>():
        return ResponseResult.ok(result.value);
      case Error<Task>():
        return ResponseResult.error(result.error);
    }
  }
}
