import 'package:flutter/widgets.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';
import 'package:mbc_mobile/screens/auth/auth_screen.dart';
import 'package:mbc_mobile/screens/home/home_screen.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/periksa_kebuntingan_screen.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_screen.dart';
import 'package:mbc_mobile/screens/peternak/peternak_screen.dart';
import 'package:mbc_mobile/screens/splash/splash_screen.dart';
import 'package:mbc_mobile/screens/strow/strow_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  // PeternakScreen.routeName: (context) => PeternakScreen(),
  PeriksaKebuntinganScreen.routeName: (context) => PeriksaKebuntinganScreen(),
  PerformaScreen.routeName: (context) => PerformaScreen(),
  StrowScreen.routeName: (context) => StrowScreen(),
  InsiminasiBuatanScreen.routeName: (context) => InsiminasiBuatanScreen(),
  PerlakuanScreen.routeName: (context) => PerlakuanScreen(),
  

};
