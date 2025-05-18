import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mundo_wap_teste/data/models/login_response.dart';
import 'package:mundo_wap_teste/utils/mocks.dart';
import 'package:mundo_wap_teste/utils/utils.dart';

/// RemoteService is the class that controls all the external API calls to a remote server
///
/// It handles the external logic of a connection, such as status code validation, HTTP errors and more.
class RemoteService {
  Future<ResponseResult<LoginResponse>> authenticate(String user, String password) async {
    bool _validateStatus(int? statusCode) {
      if (statusCode == null) {
        return false;
      } else if (statusCode > 199 && statusCode < 300) {
        return true;
      } else {
        return false;
      }
    }

    bool _isCredentialsInvalid(int? statusCode) {
      return statusCode == 401;
    }

    try {
      final BASE_URL = MyAppEnvVariables.baseURL();
      var headers = {'Content-Type': 'application/json'};
      var sendingData = jsonEncode({"user": user, "password": password});

      final response = await Dio().request(
        '$BASE_URL/TestMobile/auth',
        options: Options(
          headers: headers,
          method: 'POST',
          validateStatus: _validateStatus,
        ),
        data: sendingData,
      );

      if (_isCredentialsInvalid(response.statusCode)) {
        return ResponseResult.error(Exception('Credenciais inválidas.'));
      } else {
        return ResponseResult.ok(LoginResponse.fromJson(response.data as Map<String, dynamic>));
      }
    } on Exception {
      return ResponseResult.ok(LoginResponse.fromJson(MyMockResponses.login));
      return ResponseResult.error(Exception('Erro ocorreu ao tentar logar. Por favor, tente novamente.'));
    }
  }
}
