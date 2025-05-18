import 'package:json_annotation/json_annotation.dart';

part 'tasks_response.g.dart';

@JsonSerializable()
class TaskResponse {
  int id;
  String task_name;
  String description;
  List<FieldTaskResponse> fields;

  TaskResponse({
    required this.id,
    required this.task_name,
    required this.description,
    required this.fields,
  });

  Map<String, dynamic> toSQLMap() {
    return <String, dynamic>{
      'id': id,
      'task_name': task_name,
      'description': description,
    };
  }

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

  factory FieldTaskResponse.fromJson(Map<String, dynamic> json) => _$FieldTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FieldTaskResponseToJson(this);
}
