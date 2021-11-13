import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/hasil_bloc/hasil_bloc.dart';
import 'package:mbc_mobile/bloc/metode_bloc/metode_bloc.dart';
import 'package:mbc_mobile/bloc/periksa_kebuntingan_bloc/periksa_kebuntingan_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_sapi_bloc/peternaksapi_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/repositories/hasil_repo.dart';
import 'package:mbc_mobile/repositories/metode_repo.dart';
import 'package:mbc_mobile/repositories/periksa_kebuntingan_repo.dart';
import 'package:mbc_mobile/repositories/peternak_sapi_repo.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/form/periksa_kebuntingan_form_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PeriksaKebuntinganFormScreen extends StatelessWidget {
  final String userId;
  final String notifId;
  final Sapi? sapi;

  const PeriksaKebuntinganFormScreen(
      Key? key, this.userId, this.sapi, this.notifId)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Periksa Kebuntingan",
            style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
        create: (context) => HasilBloc(HasilRepositoryImpl()),
        child: BlocProvider(
          create: (context) => MetodeBloc(MetodeRepositoryImpl()),
          child: BlocProvider(
            create: (context) =>
                PeriksaKebuntinganBloc(PeriksaKebuntinganRepositoryImpl()),
            child: BlocProvider(
                create: (context) => SapiBloc(SapiRepositoryImpl()),
                child: PeriksaKebuntinganFormBody(null, userId, sapi, notifId)),
          ),
        ),
      ),
    );
  }
}
