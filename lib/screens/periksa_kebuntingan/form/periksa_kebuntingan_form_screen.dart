import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/periksa_kebuntingan_bloc/periksa_kebuntingan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';
import 'package:mbc_mobile/repositories/periksa_kebuntingan_repo.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/form/periksa_kebuntingan_form_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PeriksaKebuntinganFormScreen extends StatelessWidget {
  final PeriksaKebuntingan periksaKebuntingan;

  const PeriksaKebuntinganFormScreen(
      {Key? key, required this.periksaKebuntingan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Periksa Kebuntingan", style: TextStyle(color: Colors.white)),
        
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                kSecondaryColor,
                    kPrimaryColor
              ])),
        ),
      ),
      body: BlocProvider(create: (context) => PeriksaKebuntinganBloc(PeriksaKebuntinganRepositoryImpl()), 
      child: BlocProvider(create: (context) => SapiBloc(SapiRepositoryImpl()), child: PeriksaKebuntinganFormBody(periksaKebuntingan: periksaKebuntingan)),
      ),
    );
  }
}
