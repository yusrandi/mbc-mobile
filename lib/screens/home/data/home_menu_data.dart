import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/periksa_kebuntingan_screen.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_screen.dart';
import 'package:mbc_mobile/screens/peternak/peternak_screen.dart';
import 'package:mbc_mobile/screens/strow/strow_screen.dart';

class HomeMenuData {
  final IconData icon;
  final String title;
  final String route;

  HomeMenuData({required this.icon, required this.title, required this.route});

  static List<HomeMenuData> listItems = [
    HomeMenuData(icon: Icons.category, title: "Peternak", route: PeternakScreen.routeName),
    HomeMenuData(icon: FontAwesomeIcons.box, title: "PKB", route: PeriksaKebuntinganScreen.routeName),
    HomeMenuData(icon: Icons.category, title: "Performa", route: PerformaScreen.routeName),
    HomeMenuData(icon: Icons.folder, title: "Strow", route: StrowScreen.routeName),
    HomeMenuData(icon: Icons.archive, title: "IB", route: InsiminasiBuatanScreen.routeName),
    HomeMenuData(icon: FontAwesomeIcons.bookReader, title: "Perlakuan", route: PerlakuanScreen.routeName),
  ];
}
