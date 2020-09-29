import 'package:designpatterns_flutter/home_page.dart';
import 'package:designpatterns_flutter/mvvm/models/user_model.dart';
import 'package:designpatterns_flutter/mvvm/models/login_service.dart';
import 'package:designpatterns_flutter/mvvm/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginPageMVVM extends StatefulWidget {
  @override
  _LoginPageMVCState createState() => _LoginPageMVCState();
}

class _LoginPageMVCState extends State<LoginPageMVVM> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final user = User();
  PageViewModel _viewModel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _viewModel = PageViewModel(LoginService());
    _viewModel.isLoggedOut.listen((isLoggedIn) {
         if(isLoggedIn) {
           loginSuccess();
         } else {
           loginError();
         }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
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
        key: _formKey,
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
                onSaved: (email) => user.email = email,
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
                onSaved: (password) => user.password = password,
                validator: (password) {
                  if (password.isEmpty) {
                    return 'Por favor, informe uma senha válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              StreamBuilder<bool>(
                  stream: _viewModel.isLoadingOut,
                  initialData: false,
                  builder: (context, snapshot) {
                    bool isLoading = snapshot.data;
                    return RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text('Entrar'),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              _viewModel.isLoggedIn.add(user);
                            },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
