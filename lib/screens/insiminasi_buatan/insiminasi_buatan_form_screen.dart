import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/insiminasi_buatan_bloc/insiminasi_buatan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/bloc/strow_bloc/strow_bloc.dart';
import 'package:mbc_mobile/models/insiminasi_buatan_model.dart';
import 'package:mbc_mobile/repositories/insiminasi_buatan_repo.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/repositories/strow_repo.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_form_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class InsiminasiBuatanFormScreen extends StatelessWidget {
  final InsiminasiBuatan insiminasiBuatan;

  const InsiminasiBuatanFormScreen({Key? key, required this.insiminasiBuatan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Insiminasi Buatan", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
        create: (context) => InsiminasiBuatanBloc(InsiminasiBuatanRepositoryImpl()),
        child: BlocProvider(
            create: (context) => SapiBloc(SapiRepositoryImpl()),
            child: BlocProvider(create: (context) => StrowBloc(StrowRepositoryImpl()), child: InsiminasiBuatanFormBody(insiminasiBuatan: insiminasiBuatan))),
      ),
    );
  }
}
