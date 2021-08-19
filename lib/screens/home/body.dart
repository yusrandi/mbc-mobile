import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/firebase/fcm/notification_helper.dart';
import 'package:mbc_mobile/firebase/services/local_notification_services.dart';
import 'package:mbc_mobile/screens/home/top_bar.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {

  final AuthenticationBloc authenticationBloc;
  final String name;
  final int id;

  const Body({Key? key, required this.authenticationBloc, required this.name, required this.id}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late SharedPreferences sharedpref;

  @override
  void initState(){
    super.initState();

    // NotificationHelper.init();
    LocalNotificationServices.initialize(context);
    NotificationHelper.init(context);

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        child: HomeTopbar(id: widget.id, userName: widget.name, authenticationBloc: widget.authenticationBloc),
      ),
    );
  }

}
