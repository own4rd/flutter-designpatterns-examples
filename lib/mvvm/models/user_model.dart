class User {
  String email;
  String password;

  Future<bool> checkLogin() async {
    await Future.delayed(Duration(seconds: 3));
    return email == 'wagner@email.com' && password == '1234';
  }
}