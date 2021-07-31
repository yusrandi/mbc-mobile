import 'package:flutter/material.dart';
import 'package:mbc_mobile/firebase/fcm/notification_helper.dart';
import 'package:mbc_mobile/screens/home/screen/home_screen_home.dart';
import 'package:mbc_mobile/screens/home/screen/home_screen_todo.dart';
import 'package:mbc_mobile/screens/home/top_bar.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {


  @override
  void initState() {
    super.initState();

    // NotificationHelper.init();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
      child: HomeTopbar(),
      ),
    );
  }
}
