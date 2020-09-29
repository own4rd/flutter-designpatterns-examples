import 'package:designpatterns_flutter/mvc/models/login_service.dart';
import 'package:designpatterns_flutter/mvc/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginController {
  User user = User();
  final formKey = GlobalKey<FormState>();
  final LoginService loginService;

  LoginController(this.loginService);

  setUserEmail(String email) => user.email = email;
  setUserPassword(String password) => user.password = password;

  Future<bool> doLogin() async {
    if (!formKey.currentState.validate()) {
      return false;
    }

    formKey.currentState.save();
    try {
      return await loginService.checkLogin(user);
    } catch(err) {
      print(err);
      return false;
    }
  }
}
