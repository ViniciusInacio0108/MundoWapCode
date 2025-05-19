import 'package:flutter/material.dart';

import 'package:mundo_wap_teste/data/repositories/login/login_repository_remote.dart';
import 'package:mundo_wap_teste/domain/user.dart';
import 'package:mundo_wap_teste/utils/utils.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRespositoryRemote loginRemoteRepo;

  LoginViewModel({
    required this.loginRemoteRepo,
  });

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String _loginErrorMessage = '';
  String get loginErrorMessage => _loginErrorMessage;

  User? _user;
  User get user => _user ?? User.initialState();

  String get firstName => _user?.name.split(' ')[0] ?? '';

  Future<ResponseResult<User>> login(String username, String password) async {
    final result = await loginRemoteRepo.authenticate(username, password);

    switch (result) {
      case Ok<User>():
        _isAuthenticated = true;
        _user = result.value;
        notifyListeners();
        return result;
      case Error<User>():
        _loginErrorMessage = result.error.toString();
        _isAuthenticated = false;
        return result;
    }
  }
}
