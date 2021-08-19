import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/periksa_kebuntingan_bloc/periksa_kebuntingan_bloc.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/form/periksa_kebuntingan_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PeriksaKebuntinganBody extends StatefulWidget {
  @override
  _PeriksaKebuntinganBodyState createState() => _PeriksaKebuntinganBodyState();
}

class _PeriksaKebuntinganBodyState extends State<PeriksaKebuntinganBody> {
  late PeriksaKebuntinganBloc periksaKebuntinganBloc;

  @override
  void initState() {
    super.initState();

    periksaKebuntinganBloc = BlocProvider.of<PeriksaKebuntinganBloc>(context);
    periksaKebuntinganBloc.add(PeriksaKebuntinganFetchDataEvent());

    
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeriksaKebuntinganBloc, PeriksaKebuntinganState>(
      listener: (context, state) {
        if (state is PeriksaKebuntinganErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PeriksaKebuntinganSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PeriksaKebuntinganBloc, PeriksaKebuntinganState>(
          builder: (context, state) {
        EasyLoading.dismiss();

        if (state is PeriksaKebuntinganInitialState ||
            state is PeriksaKebuntinganLoadingState) {
          return _buildLoading();
        } else if (state is PeriksaKebuntinganLoadedState) {
          return body(state.datas);
        } else if (state is PeriksaKebuntinganSuccessState) {
          return body(state.datas);
        } else if (state is PeriksaKebuntinganErrorState) {
          return body(state.datas);
        } else {
          return _buildLoading();
        }
      }),
    );
  }

  Widget body(List<PeriksaKebuntingan> listKebuntingan) {
    if (listKebuntingan.length == 0) {
      return Center(
        child: Text("Data not yet"),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
            columnSpacing: 10,
            columns: [
              DataColumn(
                  label: Text("Aksi",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label:
                      Text("NO", style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Waktu PK",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Ertag Sapi",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Metode",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Hasil",
                      style: Theme.of(context).textTheme.subtitle1)),
            ],
            rows: listKebuntingan
                .map((e) => DataRow(cells: [
                      DataCell(Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PeriksaKebuntinganFormScreen(
                                                periksaKebuntingan: e)));
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
                      DataCell(Text((listKebuntingan.indexOf(e) + 1).toString(),
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.waktuPk,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.sapi!.ertag,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.metode,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.hasil,
                          style: Theme.of(context).textTheme.caption)),
                    ]))
                .toList()),
      ),
    );
  }

  void alertConfirm(PeriksaKebuntingan periksaKebuntingan) async {
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
      periksaKebuntinganBloc.add(PeriksaKebuntinganDeleteEvent(
          periksaKebuntingan: periksaKebuntingan));
      return;
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
