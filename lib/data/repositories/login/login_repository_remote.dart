import 'package:mundo_wap_teste/data/models/login_response.dart';
import 'package:mundo_wap_teste/data/repositories/login/login_repository.dart';
import 'package:mundo_wap_teste/data/services/api_client.service.dart';
import 'package:mundo_wap_teste/domain/task.dart';
import 'package:mundo_wap_teste/domain/user.dart';
import 'package:mundo_wap_teste/utils/utils.dart';

class LoginRespositoryRemote implements LoginRepository {
  final RemoteService remoteService;

  LoginRespositoryRemote({
    required this.remoteService,
  });

  @override
  Future<ResponseResult<User>> authenticate(String user, String password) async {
    final result = await remoteService.authenticate(user, password);

    switch (result) {
      case Ok<LoginResponse>():
        if (result.value.success) {
          return ResponseResult.ok(
            User(
              name: result.value.user.name,
              profile: result.value.user.profile,
              tasks: result.value.user.tasks
                  .map(
                    (task) => Task.fromData(task),
                  )
                  .toList(),
            ),
          );
        } else {
          return ResponseResult.error(Exception('Mal sucedido na resposta'));
        }

      case Error<LoginResponse>():
        return ResponseResult.error(result.error);
    }
  }
}
