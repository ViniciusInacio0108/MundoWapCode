import 'package:mundo_wap_teste/data/models/tasks_response.dart';
import 'package:mundo_wap_teste/utils/utils.dart';

abstract class TaskRepository {
  Future<ResponseResult<List<TaskResponse>>> getTasks();
}

class TaskLocalRepository implements TaskRepository {
  @override
  Future<ResponseResult<List<TaskResponse>>> getTasks() {
    throw UnimplementedError();
  }
}
