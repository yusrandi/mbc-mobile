import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/screens/auth/auth_screen.dart';
import 'package:mbc_mobile/screens/home/home_screen.dart';
import 'package:mbc_mobile/screens/peternak/peternak_screen.dart';
import 'package:mbc_mobile/screens/splash/splash_screen.dart';

class HomeMenuData {
  final IconData icon;
  final String title;
  final String route;

  HomeMenuData({required this.icon, required this.title, required this.route});

  static List<HomeMenuData> listItems = [
    HomeMenuData(icon: Icons.category, title: "Peternak", route: PeternakScreen.routeName),
    HomeMenuData(icon: FontAwesomeIcons.box, title: "PKB", route: SplashScreen.routeName),
    HomeMenuData(icon: Icons.archive, title: "IB", route: HomeScreen.routeName),
    HomeMenuData(icon: Icons.folder, title: "Strow", route: HomeScreen.routeName),
    HomeMenuData(icon: Icons.category, title: "Peternak", route: HomeScreen.routeName),
  ];
}
