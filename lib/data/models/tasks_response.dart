import 'package:json_annotation/json_annotation.dart';
import 'package:mundo_wap_teste/domain/task.dart';

part 'tasks_response.g.dart';

@JsonSerializable()
class TaskResponse {
  int id;
  bool? done;
  String task_name;
  String description;
  List<FieldTaskResponse> fields;

  TaskResponse({
    required this.id,
    required this.task_name,
    this.done,
    required this.description,
    required this.fields,
  });

  Map<String, dynamic> toSQLMap() {
    return <String, dynamic>{
      'id': id,
      'task_name': task_name,
      'description': description,
      'done': done == true ? 1 : 0,
    };
  }

  factory TaskResponse.fromSQL(Map<String, dynamic> json) => TaskResponse(
        id: json['id'],
        task_name: json['task_name'],
        done: json['done'] == 1 ? true : false,
        description: json['description'],
        fields: [],
      );

  factory TaskResponse.fromDomain(Task task) => TaskResponse(
        id: task.id,
        task_name: task.name,
        description: task.description,
        fields: task.fields
            .map(
              (field) => FieldTaskResponse(
                id: field.id,
                label: field.label,
                required: field.required,
                task_id: task.id,
                value: field.value,
                field_type: field.fieldType.toString(),
              ),
            )
            .toList(),
        done: task.done,
      );

  factory TaskResponse.fromJson(Map<String, dynamic> json) => _$TaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskResponseToJson(this);
}

@JsonSerializable()
class FieldTaskResponse {
  int id;
  int? task_id;
  String? value;
  String label;
  bool required;
  String field_type;

  FieldTaskResponse({
    required this.id,
    required this.label,
    this.value,
    this.task_id,
    required this.required,
    required this.field_type,
  });

  Map<String, dynamic> toSQLMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'required': required ? 1 : 0,
      'field_type': field_type,
      'task_id': task_id,
      'value': value,
    };
  }

  factory FieldTaskResponse.fromSQL(Map<String, dynamic> json) => FieldTaskResponse(
        id: json['id'],
        label: json['label'],
        required: json['required'] == 1 ? true : false,
        field_type: json['field_type'],
        task_id: json['task_id'],
        value: json['value'],
      );

  factory FieldTaskResponse.fromJson(Map<String, dynamic> json) => _$FieldTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FieldTaskResponseToJson(this);
}
