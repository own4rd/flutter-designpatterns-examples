import 'package:designpatterns_flutter/mvc/models/login_service.dart';
import 'package:designpatterns_flutter/mvc/models/user_model.dart';
import 'package:designpatterns_flutter/mvp/presenters/ILoginPageContract.dart';
import 'package:flutter/material.dart';

class LoginPresenter {
  User user = User();
  final formKey = GlobalKey<FormState>();
  final LoginService loginService;
  final ILoginPageContract loginPageContract;

  LoginPresenter(this.loginPageContract, {this.loginService});

  setUserEmail(String email) => user.email = email;
  setUserPassword(String password) => user.password = password;

  Future<bool> doLogin() async {
    bool isLoggedIn;
    if (!formKey.currentState.validate()) {
      isLoggedIn = false;
    }

    formKey.currentState.save();
    try {
      isLoggedIn = await loginService.checkLogin(user);
    } catch (err) {
      print(err);
      isLoggedIn = false;
    }
    if (isLoggedIn) {
      loginPageContract.loginSuccess();
    } else {
      loginPageContract.loginError();
    }
  }
}
