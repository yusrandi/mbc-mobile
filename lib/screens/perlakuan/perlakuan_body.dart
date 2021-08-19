import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/perlakuan_bloc/perlakuan_bloc.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';
import 'package:mbc_mobile/screens/perlakuan/perlakuan_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PerlakuanBody extends StatefulWidget {
  @override
  _PerlakuanBodyState createState() => _PerlakuanBodyState();
}

class _PerlakuanBodyState extends State<PerlakuanBody> {
  late PerlakuanBloc perlakuanBloc;

  @override
  void initState() {
    super.initState();

    perlakuanBloc = BlocProvider.of<PerlakuanBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    perlakuanBloc.add(PerlakuanFetchDataEvent());

    return BlocListener<PerlakuanBloc, PerlakuanState>(
      listener: (context, state) {
        if (state is PerlakuanErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PerlakuanSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
        }
      },
      child:
          BlocBuilder<PerlakuanBloc, PerlakuanState>(builder: (context, state) {
        EasyLoading.dismiss();

        if (state is PerlakuanInitialState || state is PerlakuanLoadingState) {
          return _buildLoading();
        } else if (state is PerlakuanLoadedState) {
          return body(state.datas);
        } else if (state is PerlakuanSuccessState) {
          return body(state.datas);
        } else if (state is PerlakuanErrorState) {
          return body(state.datas);
        } else {
          return _buildLoading();
        }
      }),
    );
  }

  Widget body(List<Perlakuan> list) {
    if (list.length == 0) {
      return Center(
        child: Text("Data not yet"),
      );
    }
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columnSpacing: 10,
                columns: [
                  DataColumn(
                      label: Text("Aksi",
                          style: Theme.of(context).textTheme.subtitle1)),
                  DataColumn(
                      label: Text("Tanggal Perlakuan",
                          style: Theme.of(context).textTheme.subtitle1)),
                  DataColumn(
                      label: Text("Nama Sapi",
                          style: Theme.of(context).textTheme.subtitle1)),
                  DataColumn(
                      label: Text("Jenis Obat",
                          style: Theme.of(context).textTheme.subtitle1)),
                  DataColumn(
                      label: Text("Jenis Vaksin",
                          style: Theme.of(context).textTheme.subtitle1)),
                  DataColumn(
                      label: Text("Jenis Vitamin",
                          style: Theme.of(context).textTheme.subtitle1)),
                  DataColumn(
                      label: Text("Jenis Hormon",
                          style: Theme.of(context).textTheme.subtitle1)),
                  DataColumn(
                      label: Text("Keterangan Perlakuan",
                          style: Theme.of(context).textTheme.subtitle1)),
                ], 
                rows: list.map((e) => DataRow(cells: [
                  DataCell(Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PerlakuanFormScreen(perlakuan: e))).then((value) => setState(() {}));
                                  },
                                  child: Icon(Icons.edit, color: kSecondaryColor)),
                              SizedBox(width: 8),
                              GestureDetector(
                                  onTap: () {
                                    alertConfirm(e);
                                  },
                                  child: Icon(Icons.delete, color: Colors.red))
                            ],
                  )),
                  DataCell(Text(e.tglPerlakuan,
                              style: Theme.of(context).textTheme.caption)),
                  DataCell(Text(e.sapi!.namaSapi,
                              style: Theme.of(context).textTheme.caption)),
                  DataCell(Text(e.jenisObat.toString()+" / "+e.dosisObat.toString(),
                              style: Theme.of(context).textTheme.caption)),
                  
                  DataCell(Text(e.vaksin.toString()+" / "+e.dosisVaksin.toString(),
                              style: Theme.of(context).textTheme.caption)),
                  
                  DataCell(Text(e.vitamin.toString()+" / "+e.dosisVitamin.toString(),
                              style: Theme.of(context).textTheme.caption)),
                  
                  DataCell(Text(e.hormon.toString()+" / "+e.dosisHormon.toString(),
                              style: Theme.of(context).textTheme.caption)),
                  
                  DataCell(Text(e.ketPerlakuan.toString(),
                              style: Theme.of(context).textTheme.caption)),
                  
                ])).toList()),
            ),
            
          ),
              ),
        ),
      Positioned(
        right: 0,
        bottom: 0,
        child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PerlakuanFormScreen(perlakuan: Perlakuan(id: 0, sapiId: 0, tglPerlakuan: "", jenisObat: "", dosisObat: 0, vaksin: "", dosisVaksin: 0, vitamin: "", dosisVitamin: 0, hormon: "", dosisHormon: 0, ketPerlakuan: "")))).then((value) => setState(() {}));
        },
        backgroundColor: kSecondaryColor,
        child: Icon(Icons.add),
      ),),
      ],
    );
  }

  void alertConfirm(Perlakuan perlakuan) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, delete it",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      perlakuanBloc.add(PerlakuanDeleteEvent(perlakuan: perlakuan));
      return;
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
