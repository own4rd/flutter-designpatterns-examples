import 'package:designpatterns_flutter/home_page.dart';
import 'package:designpatterns_flutter/mvc/controllers/login_controller.dart';
import 'package:designpatterns_flutter/mvc/models/login_service.dart';
import 'package:flutter/material.dart';

class LoginPageMVC extends StatefulWidget {
  @override
  _LoginPageMVCState createState() => _LoginPageMVCState();
}

class _LoginPageMVCState extends State<LoginPageMVC> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginController _loginController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loginController = LoginController(LoginService());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loginSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  _loginError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Login error'),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _loginController.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
                onSaved: _loginController.setUserEmail,
                validator: (email) {
                  if (email.isEmpty) {
                    return 'O campo não pode ser vazio.';
                  } else if (!email.contains('@')) {
                    return 'Email não é válido.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
                onSaved: _loginController.setUserPassword,
                validator: (password) {
                  if (password.isEmpty) {
                    return 'Por favor, informe uma senha válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text('Entrar'),
                  onPressed: _isLoading ? null : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (await _loginController.doLogin()) {
                      _loginSuccess();
                    } else {
                      _loginError();
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
