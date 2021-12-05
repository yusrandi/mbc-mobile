import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/laporan_bloc/laporan_bloc.dart';
import 'package:mbc_mobile/bloc/notif_bloc/notifikasi_bloc.dart';
import 'package:mbc_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:mbc_mobile/screens/birahi/form_birahi_screen.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_form_screen.dart';
import 'package:mbc_mobile/screens/panen/panen_form_screen.dart';
import 'package:mbc_mobile/screens/performa/performa_form_screen.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/form/periksa_kebuntingan_form_screen.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class TodoScreen extends StatefulWidget {
  final String userId;
  const TodoScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        BlocBuilder<NotifikasiBloc, NotifikasiState>(
          builder: (context, state) {
            print("NotifikasiBloc $state");
            if (state is NotifikasiSuccessState) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.datas.notifikasi.length,
                        itemBuilder: (context, index) {
                          var data = state.datas.notifikasi[index];
                          return GestureDetector(
                            onTap: () {
                              if (data.tanggal == dateNow &&
                                  data.status == "no") {
                                if (data.role == "4") {
                                  gotoAnotherPage(
                                      PerlakuanFormScreen(
                                          userId: widget.userId,
                                          notifikasiId: data.id.toString(),
                                          sapi: data.sapi),
                                      context);
                                } else if (data.role == "2") {
                                  gotoAnotherPage(
                                      PerformaFormScreen(
                                          null, widget.userId, null, data.sapi),
                                      context);
                                } else if (data.role == "0") {
                                  gotoAnotherPage(
                                      FormBirahiScreen(
                                          notif: data, userId: widget.userId),
                                      context);
                                } else if (data.role == "1") {
                                  gotoAnotherPage(
                                      PeriksaKebuntinganFormScreen(
                                          null,
                                          widget.userId,
                                          data.sapi,
                                          data.id.toString()),
                                      context);
                                } else if (data.role == "3") {
                                  gotoAnotherPage(
                                      InsiminasiBuatanFormScreen(
                                          null,
                                          widget.userId,
                                          data.id.toString(),
                                          data.sapi),
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
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(),
                              width: size.width,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(FontAwesomeIcons.circle,
                                            color: kPrimaryColor),
                                      ),
                                      Container(
                                        width: 3,
                                        height: 100,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Container(
                                    // height: getProportionateScreenHeight(130),
                                    margin: EdgeInsets.only(left: 5),
                                    padding: EdgeInsets.only(left: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'MBC-${data.sapi!.generasi}.${data.sapi!.anakKe}-${data.sapi!.eartagInduk}-${data.sapi!.eartag}',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    16)),
                                        Text(data.tanggal,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        Text(data.pesan,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        Container(
                                          margin: EdgeInsets.only(top: 8),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 26, vertical: 8),
                                          decoration: BoxDecoration(
                                              color: data.status != 'no'
                                                  ? kSecondaryColor
                                                  : Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Text(
                                              data.status == 'no'
                                                  ? "Belum"
                                                  : "Sudah",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              );

              //
            } else if (state is NotifikasiErrorState) {
              return buildError(state.error);
            } else {
              return buildLoading();
            }
          },
        ),
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

  void gotoAnotherPage(Widget landingPage, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return landingPage;
    })).then((value) => setState(() {}));
  }
}
