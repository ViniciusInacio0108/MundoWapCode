import 'package:mundo_wap_teste/data/models/tasks_response.dart';
import 'package:mundo_wap_teste/domain/task_field.dart';

class Task {
  int id;
  bool done;
  String name;
  String description;
  List<TaskField> fields;
  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.fields,
    required this.done,
  });

  factory Task.fromData(TaskResponse taskResponse) {
    return Task(
      id: taskResponse.id,
      name: taskResponse.task_name,
      description: taskResponse.description,
      done: false,
      fields: taskResponse.fields
          .map(
            (field) => TaskField(
              id: field.id,
              label: field.label,
              required: field.required,
              value: '',
              fieldType: TaskField.mapFieldTaskEnum(field.field_type),
            ),
          )
          .toList(),
    );
  }
}
