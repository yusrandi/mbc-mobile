
import 'package:flutter/material.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/firebase/fcm/notification_helper.dart';
import 'package:mbc_mobile/firebase/services/local_notification_services.dart';
import 'package:mbc_mobile/screens/home/home_screen.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    LocalNotificationServices.initialize(context);
    NotificationHelper.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(26),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.backGroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(Images.logoImage, height: 100),
          SizedBox(
            height: 16,
          ),
          Text(
            'Welcome To Our App',
            style: TextStyle(
              fontSize: getProportionateScreenWidth(24),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(8)),
          Text(
            'Manage all your activity in this application',
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              color: Colors.white,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, HomeScreen.routeName);
            },
            child: DefaultButton(
              text: "Get Started",
            ),
          ),
        ],
      ),
    );
  }
}
