import 'package:mundo_wap_teste/domain/user.dart';
import 'package:mundo_wap_teste/utils/utils.dart';

abstract class LoginRepository {
  Future<ResponseResult<User>> authenticate(String user, String password);
}
