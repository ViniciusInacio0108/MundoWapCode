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
  final FIELDS_TABLE = 'fields';

  Future<ResponseResult<List<TaskResponse>>> getTasksWithFields() async {
    try {
      final db = await MyDB().database;
      final tasksQuery = await db.query(TASK_TABLE);
      final fieldsQuery = await db.query(FIELDS_TABLE);

      final fieldsByTaskId = <int, List<FieldTaskResponse>>{};
      for (final fieldMap in fieldsQuery) {
        final field = FieldTaskResponse.fromSQL(fieldMap);

        fieldsByTaskId.putIfAbsent(field.task_id ?? -1, () => []).add(field);
      }

      final tasks = tasksQuery.map((taskMap) {
        final data = TaskResponse.fromSQL(taskMap);
        data.fields = fieldsByTaskId[data.id] ?? [];

        return data;
      }).toList();

      return ResponseResult.ok(tasks);
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }

  Future<ResponseResult<bool>> saveTasksWithFields(List<TaskResponse> tasks) async {
    try {
      final db = await MyDB().database;

      await db.transaction(
        (txn) async {
          final batch = txn.batch();

          for (final task in tasks) {
            await txn.insert(TASK_TABLE, task.toSQLMap());
            for (final field in task.fields) {
              batch.insert(
                FIELDS_TABLE,
                field.toSQLMap(),
              );
            }
          }

          await batch.commit(noResult: true);
        },
      );

      return ResponseResult.ok(true);
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }

  Future<ResponseResult<TaskResponse>> updateTask(TaskResponse task) async {
    try {
      final db = await MyDB().database;

      await db.transaction((txn) async {
        await txn.update(
          TASK_TABLE,
          task.toSQLMap(),
          where: 'id = ?',
          whereArgs: [task.id],
        );

        for (final field in task.fields) {
          await txn.update(
            'fields',
            field.toSQLMap(),
            where: 'id = ? AND task_id = ?',
            whereArgs: [field.id, task.id],
          );
        }
      });

      return ResponseResult.ok(task);
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }
}
