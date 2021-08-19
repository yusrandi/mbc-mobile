import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/kabupaten_bloc/kabupaten_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_bloc.dart';
import 'package:mbc_mobile/models/peternak_model.dart' as PeternakModel;
import 'package:mbc_mobile/repositories/kabupaten_repo.dart';
import 'package:mbc_mobile/repositories/peternak_repo.dart';
import 'package:mbc_mobile/screens/peternak/form/peternak_form_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PeternakFormScreen extends StatelessWidget {

  static String routeName = "peternak_form";
  final PeternakModel.Peternak peternak;
  

  PeternakFormScreen({ required this.peternak });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Peternak", style: TextStyle(color: Colors.white)),
        
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
      body: BlocProvider(
      create: (context) => KabupatenBloc(KabupatenRepositoryImpl()),
      child: BlocProvider(
        create: (context) => PeternakBloc(PeternakRepositoryImpl()),
        child: Container(padding: EdgeInsets.all(16), child: PeternakFormBody(peternak: peternak))),
    ),
      
    );
  }
}