import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/laporan_bloc/laporan_bloc.dart';
import 'package:mbc_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:mbc_mobile/utils/AppColor.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class SettingScreen extends StatefulWidget {
  final String userId;
  const SettingScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late UserBloc userBloc;

  @override
  void initState() {
    userBloc = BlocProvider.of(context);

    userBloc.add(UserFetchSingleData(id: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  BlocBuilder body() {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserErrorState) {
          return buildError(state.errorMsg);
        } else if (state is UserSingleLoadedState) {
          return Container(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              decoration: BoxDecoration(
                                  gradient: kPrimaryGradientColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
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
                                      ])),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(16)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/Cash.svg",
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
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.user.email,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        Text(state.user.hakAkses == "3" ? 'Pendamping' : 'TSR',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        Text("No Hp", style: titleDarkStyle),
                        Container(
                          width: size.width,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColor.primaryExtraSoft,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(state.user.noHp),
                        ),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        Text("Alamat Lengkap", style: titleDarkStyle),
                        Container(
                          width: size.width,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColor.primaryExtraSoft,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(state.user.alamat),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      alertConfirm();
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      width: size.width,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                          child: Text("Log Out",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(80)),
                ])),
          );
        } else {
          return buildLoading();
        }
      },
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

  void alertConfirm() async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, Logout",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      return;
    }
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
