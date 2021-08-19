import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/repositories/user_repo.dart';
import 'package:mbc_mobile/screens/auth/body.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = "auth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In", style: TextStyle(color: Colors.white))),
      body: BlocProvider(
        create: (context) => AuthenticationBloc(UserRepositoryImpl()),
        child: Container(
            child: Body()),
      ),
    );
  }
}
