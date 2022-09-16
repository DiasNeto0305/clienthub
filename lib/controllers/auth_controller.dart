import 'dart:async';

import 'package:client_hub/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';

class AuthController with ChangeNotifier {

  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  Future<void> login(String email, String password, bool isLogin) async {
    if (isLogin) {
      await _authRepository.signin(email, password);
      notifyListeners();
    } else {
      await _authRepository.signup(email, password);
      notifyListeners();
    }
  }

  void logout() {
    _authRepository.logout();
    
    notifyListeners();
  }

  bool get isAuth {
    return _authRepository.isAuth;
  }

  String? get token {
    return _authRepository.token;
  }

  String? get email {
    return _authRepository.email;
  }

  String? get userId {
    return _authRepository.userId;
  }
}
