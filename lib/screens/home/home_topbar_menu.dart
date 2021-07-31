import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mbc_mobile/utils/constants.dart';

class HomeTopbarMenu extends StatelessWidget {

  final int state;
  final int currentState;
  final String title;
  const HomeTopbarMenu({Key? key, required this.state, required this.currentState, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: state == currentState ? kSecondaryColor : Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))
      ),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(title,
              style: TextStyle(color: state == currentState ? Colors.white : kHintTextColor, fontSize: 18, fontWeight: FontWeight.bold))),
    );
  }
}
