import 'package:flutter/material.dart';
import 'package:mbc_mobile/screens/auth/body.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = "auth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In", style: TextStyle(color: Colors.black))),
      body: Container(
          child: Body()),
    );
  }
}
