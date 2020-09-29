import 'dart:async';

import 'package:designpatterns_flutter/mvvm/models/login_service.dart';
import 'package:designpatterns_flutter/mvvm/models/user_model.dart';

class PageViewModel {
  final _isLoading = StreamController<bool>();
  Sink<bool> get isLoadingIn => _isLoading.sink;
  Stream<bool> get isLoadingOut => _isLoading.stream;

  final _isLogged = StreamController<User>();
  Sink<User> get isLoggedIn => _isLogged.sink;
  Stream<bool> get isLoggedOut => _isLogged.stream.asyncMap(doLogin);

  final LoginService loginService;

  PageViewModel(this.loginService);

  Future<bool> doLogin(User user) async {
    bool isLoggedIn;
    isLoadingIn.add(true);
    try {
      isLoggedIn = await loginService.checkLogin(user);
    } catch (err) {
      print(err);
      isLoggedIn = false;
    }

    isLoadingIn.add(false);
    return isLoggedIn;
  }

  dispose() {
    _isLogged.close();
  }
}
