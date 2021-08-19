import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/performa_bloc/performa_bloc.dart';
import 'package:mbc_mobile/models/performa_model.dart';
import 'package:mbc_mobile/screens/performa/performa_form_body.dart';
import 'package:mbc_mobile/screens/performa/performa_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PerformaBody extends StatefulWidget {
  @override
  _PerformaBodyState createState() => _PerformaBodyState();
}

class _PerformaBodyState extends State<PerformaBody> {
  late PerformaBloc performaBloc;

  @override
  void initState() {
    super.initState();

    performaBloc = BlocProvider.of<PerformaBloc>(context);
    performaBloc.add(PerformaFetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PerformaBloc, PerformaState>(
      listener: (context, state) {
        if (state is PerformaErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PerformaSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
        }
      },
      child:
          BlocBuilder<PerformaBloc, PerformaState>(builder: (context, state) {
        EasyLoading.dismiss();

        if (state is PerformaInitialState || state is PerformaLoadingState) {
          return _buildLoading();
        } else if (state is PerformaLoadedState) {
          return body(state.datas);
        } else if (state is PerformaSuccessState) {
          return body(state.datas);
        } else if (state is PerformaErrorState) {
          return body(state.datas);
        } else {
          return _buildLoading();
        }
      }),
    );
  }

  Widget body(List<Performa> list) {
    if (list.length == 0) {
      return Center(
        child: Text("Data not yet"),
      );
    }
    return Container(
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
                  label: Text("Tanggal Performa",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Nama Sapi",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Tinggi Badan",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Berat Badan",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Panjang Badan",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Lingkar Dada",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("BSC",
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
                  builder: (context) => PerformaFormScreen(performa: e)));
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
              DataCell(Text(e.tanggalPerforma,
                          style: Theme.of(context).textTheme.caption)),
              DataCell(Text(e.sapi!.namaSapi,
                          style: Theme.of(context).textTheme.caption)),
              DataCell(Text(e.tinggiBadan.toString()+" cm",
                          style: Theme.of(context).textTheme.caption)),
              DataCell(Text(e.beratBadan.toString()+" cm",
                          style: Theme.of(context).textTheme.caption)),
              DataCell(Text(e.panjangBadan.toString()+" cm",
                          style: Theme.of(context).textTheme.caption)),
              DataCell(Text(e.lingkarDada.toString()+" cm",
                          style: Theme.of(context).textTheme.caption)),
              DataCell(Text(e.bsc.toString()+" cm",
                          style: Theme.of(context).textTheme.caption)),

            ])).toList()),
        ),

      ),
    );
  }

  void alertConfirm(Performa performa) async {
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
      performaBloc.add(PerformaDeleteEvent(performa: performa));
      return;
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
