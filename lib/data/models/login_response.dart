import 'package:json_annotation/json_annotation.dart';
import 'package:mundo_wap_teste/data/models/user_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  bool success;
  UserResponse user;

  LoginResponse({
    required this.success,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
