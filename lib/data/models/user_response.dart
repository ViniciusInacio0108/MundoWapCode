import 'package:json_annotation/json_annotation.dart';
import 'package:mundo_wap_teste/data/models/tasks_response.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  String name;
  String profile;
  List<TaskResponse> tasks;

  UserResponse({
    required this.name,
    required this.profile,
    required this.tasks,
  });

  UserResponse copyWith({
    String? name,
    String? profile,
    List<TaskResponse>? tasks,
  }) {
    return UserResponse(
      name: name ?? this.name,
      profile: profile ?? this.profile,
      tasks: tasks ?? this.tasks,
    );
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
