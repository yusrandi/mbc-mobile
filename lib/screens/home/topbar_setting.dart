import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/screens/auth/auth_screen.dart';
import 'package:mbc_mobile/utils/images.dart';

class TopbarSetting extends StatefulWidget {
  final String userName;
  final AuthenticationBloc authenticationBloc;

  const TopbarSetting(
      {Key? key, required this.userName, required this.authenticationBloc})
      : super(key: key);

  @override
  _TopbarSettingState createState() => _TopbarSettingState();
}

class _TopbarSettingState extends State<TopbarSetting> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, state) {
        print(state);
        if (state is AuthLoggedOutState) {
          gotoAnotherPage(
              AuthScreen(authenticationBloc: widget.authenticationBloc));
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(Images.logoImage, width: 35),
                SizedBox(width: 16),
                Text('Hello ${widget.userName}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        widget.authenticationBloc.add(LogOutEvent());
        break;
      case 'Settings':
        break;
    }
  }

  void gotoAnotherPage(Widget widget) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
