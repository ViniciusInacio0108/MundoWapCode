import 'package:mundo_wap_teste/data/models/tasks_response.dart';
import 'package:mundo_wap_teste/data/services/db.service.dart';
import 'package:mundo_wap_teste/domain/task.dart';
import 'package:mundo_wap_teste/domain/task_field.dart';
import 'package:mundo_wap_teste/utils/utils.dart';

abstract class TaskRepository {
  Future<ResponseResult<List<Task>>> getTasks();
  Future<ResponseResult<bool>> saveTasks(List<Task> tasks);
  Future<ResponseResult<Task>> updateTask(Task task);
}

class TaskLocalRepository implements TaskRepository {
  final DBService dbService;

  TaskLocalRepository({
    required this.dbService,
  });

  @override
  Future<ResponseResult<List<Task>>> getTasks() async {
    try {
      final result = await dbService.getTasksWithFields();

      switch (result) {
        case Ok<List<TaskResponse>>():
          return ResponseResult.ok(
            result.value.map(
              (task) {
                return Task(
                  id: task.id,
                  name: task.task_name,
                  description: task.description,
                  fields: task.fields
                      .map(
                        (e) => TaskField(
                          id: e.id,
                          label: e.label,
                          required: e.required,
                          fieldType: TaskField.mapFieldTaskEnum(e.field_type),
                          value: e.value ?? '',
                        ),
                      )
                      .toList(),
                  done: task.done ?? false,
                );
              },
            ).toList(),
          );
        case Error():
          return ResponseResult.error(result.error);
      }
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }

  @override
  Future<ResponseResult<bool>> saveTasks(List<Task> tasks) async {
    try {
      final data = tasks.map((e) => TaskResponse.fromDomain(e)).toList();

      await dbService.saveTasksWithFields(data);

      return ResponseResult.ok(true);
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }

  @override
  Future<ResponseResult<Task>> updateTask(Task task) async {
    final data = TaskResponse.fromDomain(task);

    final result = await dbService.updateTask(data);

    switch (result) {
      case Ok<TaskResponse>():
        return ResponseResult.ok(Task.fromData(result.value));
      case Error<TaskResponse>():
        return ResponseResult.error(result.error);
    }
  }
}
