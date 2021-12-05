import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/laporan_bloc/laporan_bloc.dart';
import 'package:mbc_mobile/bloc/notif_bloc/notifikasi_bloc.dart';
import 'package:mbc_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:mbc_mobile/screens/birahi/form_birahi_screen.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_form_screen.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_screen.dart';
import 'package:mbc_mobile/screens/new_home_page/home_card_peternak.dart';
import 'package:mbc_mobile/screens/new_home_page/home_card_sapi.dart';
import 'package:mbc_mobile/screens/panen/panen_form_screen.dart';
import 'package:mbc_mobile/screens/panen/panen_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_form_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/form/periksa_kebuntingan_form_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/periksa_kebuntingan_screen.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_form_screen.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotifikasiBloc notifikasiBloc;
  late LaporanBloc laporanBloc;
  late UserBloc userBloc;

  List<Notifikasi> listNotif = [];

  String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    notifikasiBloc = BlocProvider.of(context);
    laporanBloc = BlocProvider.of(context);
    userBloc = BlocProvider.of(context);

    userBloc.add(UserFetchSingleData(id: widget.userId));

    laporanBloc.add(LaporanFetchDataEvent(widget.userId));
    notifikasiBloc.add(NotifFetchByUserId(id: int.parse(widget.userId)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Container body() {
    final size = MediaQuery.of(context).size;

    return Container(
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
                                  return Text(". . .",
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
                                cardKinerja(),
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

        BlocBuilder<NotifikasiBloc, NotifikasiState>(
          builder: (context, state) {
            if (state is NotifikasiSuccessState) {
              listNotif = [];

              state.datas.notifikasi.forEach((e) {
                if (e.status == "no") {
                  var date1 =
                      DateTime.parse(e.tanggal).millisecondsSinceEpoch.toInt();
                  var date2 =
                      DateTime.parse(dateNow).millisecondsSinceEpoch.toInt();

                  if (e.role == "0" && date1 <= date2) {
                    listNotif.add(e);
                  } else {
                    if (e.tanggal == dateNow) {
                      listNotif.add(e);
                    }
                  }
                }
              });
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listNotif.length,
                      itemBuilder: (context, index) {
                        var data = listNotif[index];
                        return notifCard(data);
                      }),
                ],
              );

              //
            } else if (state is NotifikasiErrorState) {
              return buildError(state.error);
            } else {
              return buildLoading();
            }
          },
        ),

        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text("Ongoing Promo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: SizeConfig.screenWidth,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(colors: [
              Colors.green.shade100,
              kPrimaryColor,
            ]),
          ),
          child: Row(
            children: [
              Expanded(child: Image.asset(Images.farmImage)),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Have u done your progress today ?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(16)),
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Featured Service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        // HomeMenuCard(),
        menuList(),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text("Cattle",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        HomeCardSapi(userId: widget.userId.toString()),

        SizedBox(height: getProportionateScreenHeight(16)),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text("Cattle Farmer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        HomeCardPeternak(userId: widget.userId.toString()),

        SizedBox(height: getProportionateScreenHeight(80)),
      ])),
    );
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

  GestureDetector notifCard(Notifikasi data) {
    return GestureDetector(
      onTap: () {
        if (data.role == "4") {
          gotoAnotherPage(
              PerlakuanFormScreen(
                  userId: widget.userId,
                  notifikasiId: data.id.toString(),
                  sapi: data.sapi),
              context);
        } else if (data.role == "2") {
          gotoAnotherPage(
              PerformaFormScreen(null, widget.userId, null, data.sapi),
              context);
        } else if (data.role == "1") {
          gotoAnotherPage(
              PeriksaKebuntinganFormScreen(
                  null, widget.userId, data.sapi, data.id.toString()),
              context);
        } else if (data.role == "0") {
          gotoAnotherPage(
              FormBirahiScreen(notif: data, userId: widget.userId), context);
        } else if (data.role == "3") {
          gotoAnotherPage(
              InsiminasiBuatanFormScreen(
                  null, widget.userId, data.id.toString(), data.sapi),
              context);
        } else if (data.role == "5") {
          gotoAnotherPage(
              PanenFormScreen(
                null,
                widget.userId,
                data.sapi,
                data.id.toString(),
              ),
              context);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: 40,
        decoration: BoxDecoration(
            color: kSecondaryColor, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                  "${data.pesan} ke sapi MBC-${data.sapi!.generasi}.${data.sapi!.anakKe}-${data.sapi!.eartagInduk}-${data.sapi!.eartag}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 8),
            SvgPicture.asset("assets/icons/Bell.svg", color: Colors.white),
          ],
        ),
      ),
    );
  }

  Column menuList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        PerformaScreen(userId: widget.userId.toString()),
                        context),
                    child: homeMenu(Icons.insert_chart, "Performa"))),
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        PerlakuanScreen(userId: widget.userId.toString()),
                        context),
                    child: homeMenu(FontAwesomeIcons.bookReader, "Perlakuan"))),
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        PeriksaKebuntinganScreen(id: widget.userId.toString()),
                        context),
                    child: homeMenu(FontAwesomeIcons.box, "PKB"))),
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        InsiminasiBuatanScreen(
                            userId: widget.userId.toString()),
                        context),
                    child: homeMenu(Icons.archive, "IB"))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () => gotoAnotherPage(
                        PanenScreen(null, widget.userId.toString()), context),
                    child:
                        homeMenu(Icons.home_repair_service_rounded, "Panen"))),
            Expanded(child: Container()),
            Expanded(child: Container()),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  Widget homeMenu(IconData icon, String title) {
    return Container(
      height: 80,
      child: Container(
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[100]),
              child: Icon(
                icon,
                color: kSecondaryColor,
              ),
            ),
            Text(title,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  void gotoAnotherPage(Widget landingPage, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return landingPage;
    })).then((value) => setState(() {}));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildError(String msg) {
    return Center(
      child: Text(msg,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }
}
