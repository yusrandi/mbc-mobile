import 'package:flutter/material.dart';
import 'package:mbc_mobile/firebase/fcm/notification_helper.dart';
import 'package:mbc_mobile/firebase/services/local_notification_services.dart';
import 'package:mbc_mobile/screens/home/top_bar.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name = ". . .";
  late SharedPreferences sharedpref;

  @override
  void initState(){
    super.initState();

    // NotificationHelper.init();
    LocalNotificationServices.initialize(context);
    NotificationHelper.init(context);

    getFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        child: HomeTopbar(userName: name),
      ),
    );
  }

  void getFromSharedPreferences() async {
    sharedpref = await SharedPreferences.getInstance();

    setState(() {
      name = sharedpref.getString("name")!;
      print("Body Home "+name);
    });
  }
}
