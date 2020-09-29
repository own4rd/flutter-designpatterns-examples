// import 'package:designpatterns_flutter/mvc/view/login_page.dart';
// import 'package:designpatterns_flutter/mvp/views/login_page.dart';
import 'package:designpatterns_flutter/mvvm/views/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Patterns',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPageMVVM(),
    );
  }
}