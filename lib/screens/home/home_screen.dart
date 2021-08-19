import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/screens/auth/auth_screen.dart';
import 'package:mbc_mobile/screens/home/body.dart';
import 'package:mbc_mobile/utils/images.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "home";
  final AuthenticationBloc authenticationBloc;
  final String email;
  final int id;

  const HomeScreen({Key? key, required this.authenticationBloc, required this.email, required this.id}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthenticationBloc, AuthenticationState>(listener: (context, state){
        print(state);
        if (state is AuthLoggedOutState) {
          gotoAnotherPage(
              AuthScreen(authenticationBloc: authenticationBloc), context);
        }
    },
      child: Scaffold(
        body: Body(authenticationBloc: authenticationBloc, name: email, id: id),
        appBar: AppBar(
          title: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(Images.logoImage, width: 35),
                  SizedBox(width: 16),
                  Text('Hello $email',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              PopupMenuButton<String>(
                onSelected: handleClick,
                color: Colors.white,
                itemBuilder: (BuildContext context) {
                  return {'Logout', 'Settings'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),
          actions: [],),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        authenticationBloc.add(LogOutEvent());
        break;
      case 'Settings':
        break;
    }
  }

  void gotoAnotherPage(Widget widget, BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
