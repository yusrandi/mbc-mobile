import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_event.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_state.dart';
import 'package:mbc_mobile/models/peternak_model.dart';
import 'package:mbc_mobile/screens/peternak/form/peternak_form_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';

class PeternakBody extends StatefulWidget {
  const PeternakBody({Key? key}) : super(key: key);

  @override
  _PeternakBodyState createState() => _PeternakBodyState();
}

class _PeternakBodyState extends State<PeternakBody> {
  late PeternakBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<PeternakBloc>(context);
    _bloc.add(PeternakFetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return _pageBody();
  }

  Widget _pageBody() {
    return BlocListener<PeternakBloc, PeternakState>(
      listener: (context, state) {
        if (state is PeternakErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.msg)));
        } else if (state is PeternakSuccessState) {
          _alertSuccess(state.msg);
        }
      },
      child: BlocBuilder<PeternakBloc, PeternakState>(
        builder: (context, state) {
          print("state $state");
          if (state is PeternakInitialState || state is PeternakLoadingState) {
            return _buildLoading();
          } else if (state is PeternakLoadedState) {
            return _buildPeternak(state.datas);
          } else if (state is PeternakSuccessState) {
            return _buildPeternak(state.datas);
          } else if (state is PeternakErrorState) {
            return _buildPeternak(state.datas);
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Widget _buildPeternak(List<Peternak> list) {
    if (list.length == 0) {
      return Center(
        child: Text("Peternak not Found"),
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
                  label: Text("Kode Peternak",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Nama Peternak",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("No Hp",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Tgl Lahir",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("J. Anggota",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Luas Lahan",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Kelompok",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Kabupaten",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Kecamatan",
                      style: Theme.of(context).textTheme.subtitle1)),
              DataColumn(
                  label: Text("Desa",
                      style: Theme.of(context).textTheme.subtitle1)),
            ],
            rows: list
                .map((e) => DataRow(cells: [
                      DataCell(Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PeternakFormScreen(peternak: e)));

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
                      DataCell(Text((list.indexOf(e) + 1).toString(),
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.kodePeternak,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.namaPeternak,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.noHp,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.tglLahir,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.jumlahAnggota,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.luasLahan,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.kelompok,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.desa!.kecamatan!.kabupaten!.name,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.desa!.kecamatan!.name,
                          style: Theme.of(context).textTheme.caption)),
                      DataCell(Text(e.desa!.name,
                          style: Theme.of(context).textTheme.caption)),
                    ]))
                .toList()),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String msg) {
    return Center(
      child: Text(msg,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }

  void alertConfirm(Peternak peternak) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, delete it",
            type: ArtSweetAlertType.warning));

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      _bloc.add(PeternakDeleteEvent(peternak: peternak));
      return;
    }
  }

  void _alertSuccess(String msg) {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs:
            ArtDialogArgs(type: ArtSweetAlertType.success, title: msg));
  }
}
