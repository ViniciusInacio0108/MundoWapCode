import 'package:mundo_wap_teste/domain/task.dart';

class User {
  String name;
  String profile;
  List<Task> tasks;
  User({
    required this.name,
    required this.profile,
    required this.tasks,
  });

  factory User.initialState() => User(name: '', profile: '', tasks: []);
}
