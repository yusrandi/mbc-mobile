import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/insiminasi_buatan_bloc/insiminasi_buatan_bloc.dart';
import 'package:mbc_mobile/models/insiminasi_buatan_model.dart';
import 'package:mbc_mobile/screens/insiminasi_buatan/insiminasi_buatan_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';

class InsiminasiBuatanBody extends StatefulWidget {
  @override
  _InsiminasiBuatanBodyState createState() => _InsiminasiBuatanBodyState();
}

class _InsiminasiBuatanBodyState extends State<InsiminasiBuatanBody> {
  late InsiminasiBuatanBloc insiminasiBuatanBloc;

  @override
  void initState() {
    super.initState();

    insiminasiBuatanBloc = BlocProvider.of<InsiminasiBuatanBloc>(context);
  }
  
  @override
  Widget build(BuildContext context) {

    insiminasiBuatanBloc.add(InsiminasiBuatanFetchDataEvent());

    print("InsiminasiBuatanBody");
    return BlocListener<InsiminasiBuatanBloc, InsiminasiBuatanState>(
      listener: (context, state) {
        if (state is InsiminasiBuatanErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is InsiminasiBuatanSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<InsiminasiBuatanBloc, InsiminasiBuatanState>(builder: (context, state) {
        EasyLoading.dismiss();

        if (state is InsiminasiBuatanInitialState || state is InsiminasiBuatanLoadingState) {
          return _buildLoading();
        } else if (state is InsiminasiBuatanLoadedState) {
          return body(state.datas);
        } else if (state is InsiminasiBuatanSuccessState) {
          return body(state.datas);
        } else if (state is InsiminasiBuatanErrorState) {
          return body(state.datas);
        } else {
          return _buildLoading();
        }
      }),
    );
  }

  Widget body(List<InsiminasiBuatan> list) {
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
          right: 0,
          left: 0,
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
                        label: Text("Tanggal IB",
                            style: Theme.of(context).textTheme.subtitle1)),
                    DataColumn(
                        label: Text("Nama Sapi",
                            style: Theme.of(context).textTheme.subtitle1)),
                    DataColumn(
                        label: Text("Kode Batch Strow",
                            style: Theme.of(context).textTheme.subtitle1)),
                    DataColumn(
                        label: Text("Dosis",
                            style: Theme.of(context).textTheme.subtitle1)),
                    
                  ],
                  rows: list
                      .map((e) => DataRow(cells: [
                            DataCell(Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InsiminasiBuatanFormScreen(insiminasiBuatan: e))).then((value) => setState(() {}));    
                                    },
                                    child:
                                        Icon(Icons.edit, color: kSecondaryColor)),
                                SizedBox(width: 8),
                                GestureDetector(
                                    onTap: () {
                                      alertConfirm(e);
                                    },
                                    child: Icon(Icons.delete, color: Colors.red))
                              ],
                            )),
                            DataCell(Text(e.waktuIb,
                                style: Theme.of(context).textTheme.caption)),
                            DataCell(Text(e.sapi!.namaSapi,
                                style: Theme.of(context).textTheme.caption)),
                            DataCell(Text(e.strow!.kodeBatch,
                                style: Theme.of(context).textTheme.caption)),
                            DataCell(Text(e.dosisIb.toString(),
                                style: Theme.of(context).textTheme.caption)),
                          ]))
                      .toList()),
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
                  builder: (context) => InsiminasiBuatanFormScreen(insiminasiBuatan: InsiminasiBuatan(id: 0, waktuIb: "", dosisIb: 0, strowId: 0, sapiId: 0)))).then((value) => setState(() {}));
        },
        backgroundColor: kSecondaryColor,
        child: Icon(Icons.add),
      ),),
      ],
    );
  }

  void alertConfirm(InsiminasiBuatan insiminasiBuatan) async {
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
      insiminasiBuatanBloc.add(InsiminasiBuatanDeleteEvent(insiminasiBuatan: insiminasiBuatan));
      return;
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
