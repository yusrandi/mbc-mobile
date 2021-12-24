import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/laporan_bloc/laporan_bloc.dart';
import 'package:mbc_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_cek_birahi.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_ib.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_menu_home.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_menu_utama.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_panen.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_performa.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_perlakuan.dart';
import 'package:mbc_mobile/screens/new_home_page/guide_screens/guide_pkb.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class GuideScreen extends StatefulWidget {
  final String userId;

  const GuideScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _GuideScreenState createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final listItem = [
      Item('Menu Utama', GuideMenuUtama()),
      Item('Menu Home', GuideMenuHome()),
      Item('Cek Birahi', GuideCekBirahi()),
      Item('Insiminasi Buatan', GuideIB()),
      Item('Periksa Kebuntingan', GuidePKB()),
      Item('Performa/Recording', GuidePerforma()),
      Item('Perlakuan Kesehatan', GuidePerlakuan()),
      Item('Panen', GuidePanen()),
    ];

    return Container(
      height: size.height,
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: size.height * 0.30,
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    decoration: BoxDecoration(gradient: kPrimaryGradientColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserSingleLoadedState) {
                                  return RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "Hello\n",
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '${state.user.name}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ]));
                                } else {
                                  return Text(state.toString(),
                                      style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold));
                                }
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(16)),
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/Cash.svg",
                                    color: Colors.white),
                                SizedBox(width: 16),
                                cardKinerja()
                              ],
                            )
                          ],
                        )),
                        Image.asset(
                          Images.farmerImage,
                          width: 200,
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  top: size.height * 0.30 - 20,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                  )),
            ],
          ),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.search, color: kSecondaryColor),
              ),
              Expanded(
                  child: Container(
                child: Text('What are you looking for ?'),
              ))
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(16)),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listItem.length,
              itemBuilder: (context, index) {
                Item item = listItem[index];
                return GestureDetector(
                  onTap: () {
                    gotoAnotherPage(item.screen, context);
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(Icons.file_copy, color: kSecondaryColor),
                        ),
                        Expanded(
                            child: Container(
                          child:
                              Text(item.name, style: TextStyle(fontSize: 20)),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child:
                              Icon(Icons.chevron_right, color: kSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: getProportionateScreenHeight(80)),
      ])),
    );
  }

  void gotoAnotherPage(Widget landingPage, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return landingPage;
    })).then((value) => setState(() {}));
  }

  BlocBuilder<LaporanBloc, LaporanState> cardKinerja() {
    return BlocBuilder<LaporanBloc, LaporanState>(
      builder: (context, state) {
        if (state is LaporanLoadedState) {
          var total = 0;
          state.model.laporan.forEach((e) {
            total += int.parse(e.upah);
          });
          return Positioned(
            top: 0,
            right: 0,
            bottom: 80,
            left: 0,
            child: Center(
              child: Text(
                  "Rp. " +
                      NumberFormat("#,##0", "en_US")
                          .format(int.parse(total.toString())),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          );
        }
        if (state is LaporanErrorState) {
          return Center(child: Text(state.errorMsg));
        } else {
          return Center(
              child: Text('. . .',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold)));
        }
      },
    );
  }
}

class Item {
  final String name;
  final Widget screen;
  Item(this.name, this.screen);
}
