import 'package:designpatterns_flutter/mvc/models/user_model.dart';

class LoginService {
  Future<bool> checkLogin(User user) async {
    await Future.delayed(Duration(seconds: 3));
    return user.email == 'wagner@email.com' && user.password == '1234';
  }
}