import 'package:mundo_wap_teste/data/database/sql_database.dart';
import 'package:mundo_wap_teste/data/models/tasks_response.dart';
import 'package:mundo_wap_teste/utils/utils.dart';

/// DDService is where all the complicated datas should be saved.
///
/// It works with SQFlite for more complex data structure and storage. That need tables and a more complete DB.
///
/// For simpler data like Strings, use [SharedPreferencesService]
class DBService {
  final TASK_TABLE = 'tasks';

  Future<ResponseResult<List<TaskResponse>>> getTasks() async {
    try {
      final db = await MyDB().database;
      final task = await db.query(TASK_TABLE);

      return ResponseResult.ok(task.map((e) => TaskResponse.fromJson(e)).toList());
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }

  Future<ResponseResult<int>> insertTask(TaskResponse task) async {
    try {
      final db = await MyDB().database;

      final id = await db.insert(TASK_TABLE, task.toSQLMap());

      return ResponseResult.ok(id);
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }

  Future<ResponseResult<int>> updateTask(TaskResponse task) async {
    try {
      final db = await MyDB().database;
      return ResponseResult.ok(
        await db.update('tasks', task.toSQLMap(), where: 'id = ?', whereArgs: [task.id]),
      );
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }
}
