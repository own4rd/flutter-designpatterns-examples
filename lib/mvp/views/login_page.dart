import 'package:designpatterns_flutter/home_page.dart';
import 'package:designpatterns_flutter/mvc/models/login_service.dart';
import 'package:designpatterns_flutter/mvp/presenters/ILoginPageContract.dart';
import 'package:designpatterns_flutter/mvp/presenters/login_presenter.dart';
import 'package:flutter/material.dart';

class LoginPageMVP extends StatefulWidget {
  @override
  _LoginPageMVCState createState() => _LoginPageMVCState();
}

class _LoginPageMVCState extends State<LoginPageMVP> implements ILoginPageContract{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginPresenter _loginPresenter;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loginPresenter = LoginPresenter(this, loginService: LoginService());
  }

  @override
  void dispose() {
    super.dispose();
  }

  loginSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  loginError() {
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
        key: _loginPresenter.formKey,
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
                onSaved: _loginPresenter.setUserEmail,
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
                onSaved: _loginPresenter.setUserPassword,
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
                    _loginPresenter.doLogin();
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
