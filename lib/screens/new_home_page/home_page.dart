import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbc_mobile/bloc/auth_bloc/authentication_bloc.dart';
import 'package:mbc_mobile/bloc/laporan_bloc/laporan_bloc.dart';
import 'package:mbc_mobile/bloc/notif_bloc/notifikasi_bloc.dart';
import 'package:mbc_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:mbc_mobile/repositories/laporan_repo.dart';
import 'package:mbc_mobile/repositories/notifikasi_repo.dart';
import 'package:mbc_mobile/repositories/user_repo.dart';
import 'package:mbc_mobile/screens/new_home_page/screen/guide_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/screen/home_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/screen/setting_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/screen/todo_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomePage extends StatefulWidget {
  final String userId;
  final String hakAkses;
  final AuthenticationBloc bloc;

  const HomePage(
      {Key? key,
      required this.userId,
      required this.bloc,
      required this.hakAkses})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotifikasiBloc(NotifikasiRepositoryImpl()),
      child: BlocProvider(
        create: (context) => LaporanBloc(LaporanRepositoryImpl()),
        child: BlocProvider(
          create: (context) => UserBloc(UserRepositoryImpl()),
          child: Scaffold(
            body: Stack(
              children: [
                _index == 0
                    ? HomeScreen(
                        userId: widget.userId, hakAkses: widget.hakAkses)
                    : _index == 1
                        ? TodoScreen(
                            userId: widget.userId, hakAkses: widget.hakAkses)
                        : _index == 2
                            ? GuideScreen(userId: widget.userId)
                            : SettingScreen(
                                userId: widget.userId, bloc: widget.bloc),
                Positioned(
                  bottom: 0,
                  left: getProportionateScreenWidth(30),
                  right: getProportionateScreenWidth(30),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                                  _listMenu("assets/icons/home-filled.svg", 0)),
                          Expanded(
                              flex: 1,
                              child: _listMenu(
                                  "assets/icons/bookmark-filled.svg", 1)),
                          Expanded(
                              flex: 1,
                              child: _listMenu(
                                  "assets/icons/Question mark.svg", 2)),
                          Expanded(
                              flex: 1,
                              child: _listMenu("assets/icons/Settings.svg", 3)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listMenu(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _index = index;
        });
      },
      child: Container(
        height: getProportionateScreenHeight(70),
        decoration: BoxDecoration(
            color: _index == index ? kSecondaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Center(
            child: SvgPicture.asset(
              title,
              color: _index == index ? Colors.white : kSecondaryColor,
              height: 30,
            ),
          ),
        ),
      ),
    );
  }
}
