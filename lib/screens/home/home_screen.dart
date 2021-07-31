import 'package:flutter/material.dart';
import 'package:mbc_mobile/screens/home/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "home";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Body(),
    );
  }
}
