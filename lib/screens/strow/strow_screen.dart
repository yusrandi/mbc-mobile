import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/strow_bloc/strow_bloc.dart';
import 'package:mbc_mobile/models/strow_model.dart';
import 'package:mbc_mobile/repositories/strow_repo.dart';
import 'package:mbc_mobile/screens/strow/strow_body.dart';
import 'package:mbc_mobile/screens/strow/strow_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';

class StrowScreen extends StatelessWidget {
  static String routeName = "strow";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Strow",
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
        create: (context) =>
            StrowBloc(StrowRepositoryImpl()),
        child: Container(
            padding: EdgeInsets.all(16), child: StrowBody()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StrowFormScreen(strow: Strow(id: 0, sapiId: 0, kodeBatch: "", batch: ""))));
        },
        backgroundColor: kSecondaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}