import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_bloc.dart';
import 'package:mbc_mobile/models/peternak_model.dart';
import 'package:mbc_mobile/repositories/peternak_repo.dart';
import 'package:mbc_mobile/screens/peternak/form/peternak_form_screen.dart';
import 'package:mbc_mobile/screens/peternak/peternak_body.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PeternakScreen extends StatelessWidget {
  static String routeName = "peternak";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Peternak", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kSecondaryColor, kPrimaryColor])),
        ),
      ),
      body: BlocProvider(
        create: (context) => PeternakBloc(PeternakRepositoryImpl()),
        child: Container(padding: EdgeInsets.all(16), child: PeternakBody()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PeternakFormScreen(peternak: Peternak(
            id: 0,
            kodePeternak: "",
            namaPeternak: "",
            tglLahir: "",
            jumlahAnggota: "",
            kelompok: "",
            luasLahan: "",
            noHp: "",
            desaId: 0,
          ))));
        },
        backgroundColor: kSecondaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
