import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/perlakuan_bloc/perlakuan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';
import 'package:mbc_mobile/repositories/perlakuan_repo.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_form_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PerlakuanFormScreen extends StatelessWidget {
  final Perlakuan perlakuan;

  const PerlakuanFormScreen({Key? key, required this.perlakuan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Perlakuan", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
        create: (context) => PerlakuanBloc(PerlakuanRepositoryImpl()),
        child: BlocProvider(
            create: (context) => SapiBloc(SapiRepositoryImpl()),
            child: PerlakuanFormBody(perlakuan: perlakuan)),
      ),
    );
  }
}
