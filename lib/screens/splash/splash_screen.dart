import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/repositories/user_repo.dart';
import 'package:mbc_mobile/screens/splash/body.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class SplashScreen extends StatelessWidget {

  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthenticationBloc(UserRepositoryImpl()),
        child: Body()),
    );
  }
}
