import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/kabupaten_bloc/kabupaten_bloc.dart';
import 'package:mbc_mobile/bloc/kabupaten_bloc/kabupaten_event.dart';
import 'package:mbc_mobile/bloc/kabupaten_bloc/kabupaten_state.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_event.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/kabupaten_model.dart';
import 'package:mbc_mobile/models/peternak_model.dart' as PeternakModel;
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class PeternakFormBody extends StatefulWidget {
  final PeternakModel.Peternak peternak;

  PeternakFormBody({required this.peternak});

  @override
  _PeternakFormBodyState createState() => _PeternakFormBodyState();
}

class _PeternakFormBodyState extends State<PeternakFormBody> {
  static const String TAG = "_PeternakBodyState";
  final _formKey = GlobalKey<FormState>();

  String _name = "",
      _kode = "",
      _noHp = "",
      _tglLahir = "",
      _jumlahAnggota = "",
      _luasLahan = "",
      _kelompok = "";

  int resDesaId = 0;

  late KabupatenBloc kabupatenBloc;
  late PeternakBloc peternakBloc;

  int kabDropDownValue = 0;
  int kecDropDownValue = 0;
  int desaDropDownValue = 0;

  List<Kecamatans> listKec = [];
  List<Desas> listDesa = [];

  final _resKode = new TextEditingController();
  final _resName = new TextEditingController();
  final _resNoHp = new TextEditingController();
  final _resTglLahir = new TextEditingController();
  final _resJumlahAnggota = new TextEditingController();
  final _resLuasLahan = new TextEditingController();
  final _resKelompok = new TextEditingController();

  @override
  void initState() {
    super.initState();

    kabupatenBloc = BlocProvider.of<KabupatenBloc>(context);
    peternakBloc = BlocProvider.of<PeternakBloc>(context);

    kabupatenBloc.add(KabupatenFetchDataEvent());



    if(widget.peternak.id != 0){
      listKec
          .add(Kecamatans(id: 0, kabupatenId: 0, name: "Kecamatan", desas: []));

      PeternakModel.Kecamatan kec = widget.peternak.desa!.kecamatan!;

      listKec.add(Kecamatans(id: kec.id, kabupatenId: kec.kabupatenId, name: kec.name, desas: []));
      kabDropDownValue = widget.peternak.desa!.kecamatan!.kabupatenId;
      kecDropDownValue = widget.peternak.desa!.kecamatanId;

      listDesa.add(Desas(id: 0, kecamatanId: 0, name: "Desa"));
      PeternakModel.Desa desa = widget.peternak.desa!;
      listDesa.add(Desas(id: desa.id, kecamatanId: desa.kecamatanId, name: desa.name));
      desaDropDownValue = widget.peternak.desaId;

      resDesaId = desa.id;

      _resKode.text = widget.peternak.kodePeternak;
      _resName.text = widget.peternak.namaPeternak;
      _resNoHp.text = widget.peternak.noHp;
      _resTglLahir.text = widget.peternak.tglLahir;
      _resJumlahAnggota.text = widget.peternak.jumlahAnggota;
      _resLuasLahan.text = widget.peternak.luasLahan;
      _resKelompok.text = widget.peternak.kelompok;

    }

  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Kabupaten"),
            loadKabupaten(),
            SizedBox(height: getProportionateScreenHeight(16)),

            SizedBox(height: getProportionateScreenHeight(16)),
            Text("Kode Peternak "),
            buildFormField(
                'Input Kode Peternak', _kode, _resKode),
            SizedBox(height: getProportionateScreenHeight(16)),
            Text("Nama Peternak "),
            buildFormField(
                'Input Kode Peternak', _name, _resName),
            SizedBox(height: getProportionateScreenHeight(16)),
            Text("Nomor HP "),
            buildFormField('0880 999 xxxx', _noHp, _resNoHp),
            SizedBox(height: getProportionateScreenHeight(16)),
            Text("Tanggal Lahir "),
            buildFormField('ex: 21/12/2021 format : dd/mm/yyyy', _tglLahir,
                _resTglLahir),
            SizedBox(height: getProportionateScreenHeight(16)),
            Text("Jumlah Anggota "),
            buildFormField(
                'ex: 21 jiwa', _jumlahAnggota, _resJumlahAnggota),
            SizedBox(height: getProportionateScreenHeight(16)),
            Text("Luas Lahan "),
            buildFormField('ex: 21 Ha', _luasLahan, _resLuasLahan),
            SizedBox(height: getProportionateScreenHeight(16)),
            Text("Kelompok "),
            buildFormField(
                'Input Kelompok', _kelompok, _resKelompok),
            SizedBox(height: getProportionateScreenHeight(16)),
            SizedBox(height: getProportionateScreenHeight(16)),
            GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                if (_formKey.currentState!.validate()) {
                  if (resDesaId == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Harap Memilih Desa')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );

                    PeternakModel.Peternak peternak = PeternakModel.Peternak(
                        id: widget.peternak.id,
                        kodePeternak: _resKode.text.trim(),
                        namaPeternak: _resName.text.trim(),
                        noHp: _resNoHp.text.trim(),
                        tglLahir: _resTglLahir.text.trim(),
                        jumlahAnggota: _resJumlahAnggota.text.trim(),
                        luasLahan: _resLuasLahan.text.trim(),
                        kelompok: _resKelompok.text.trim(),
                        desaId: resDesaId);

                    print("result ${_resName.text.trim()}");
                    widget.peternak.id == 0
                        ? peternakBloc
                            .add(PeternakStoreEvent(peternak: peternak))
                        : peternakBloc
                            .add(PeternakUpdateEvent(peternak: peternak));
                  }
                }
              },
              child: DefaultButton(
                text: "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadKabupaten() {
    return BlocListener<KabupatenBloc, KabupatenState>(
      listener: (context, state) {
        if (state is KabupatenErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      child: BlocBuilder<KabupatenBloc, KabupatenState>(
        builder: (context, state) {
          print("state $state");
          if (state is KabupatenLoadedState) {

            List<Kabupaten> itemList = [];
            itemList.add(Kabupaten(id: 0, name: "Kabupaten", kecamatans: []));
            itemList.addAll(state.datas);

            return _buildKabupaten(itemList);

          } else if (state is KabupatenInitialState ||
              state is KabupatenLoadingState) {
            return _buildLoading();
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Widget _buildKabupaten(List<Kabupaten> list) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: kSecondaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton<int>(
            value: kabDropDownValue,
            hint: Text("Kabupaten"),
            items: list.map((Kabupaten value) {
              return DropdownMenuItem<int>(
                value: value.id,
                child: new Text(value.name),
              );
            }).toList(),
            onChanged: (newValue) {
              print(newValue);


              setState(() {
                kabDropDownValue = newValue!;

                listKec.clear();

                listKec
                    .add(Kecamatans(id: 0, kabupatenId: 0, name: "Kecamatan", desas: []));

                kecDropDownValue = 0;

                if(kabDropDownValue != 0){
                  list.forEach((element) {
                    print("list  ${element.id}, value $kabDropDownValue");

                    if(element.id == kabDropDownValue){
                      listKec.addAll(element.kecamatans);
                    }
                  });
                }

              });
            },
          ),
        ),
        SizedBox(height: 8),
        Text("Kecamatan"),
        _buildKecamatan(),
        SizedBox(height: 8),
        Text("Desa"),
        _buildDesa()
      ],
    );
  }

  Widget _buildKecamatan() {
    print("_buildKecamatan ${listKec.length}, value $kecDropDownValue");

    listKec.forEach((e) {
      print("list kecamatan $e");
    });
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<int>(
        value: kecDropDownValue,
        hint: Text("Kecamatan"),
        items: listKec.map((Kecamatans value) {
          return DropdownMenuItem<int>(
            value: value.id,
            child: new Text(value.name),
          );
        }).toList(),
        onChanged: (newValue) {
          print(newValue);
          setState(() {
            kecDropDownValue = newValue!;

            listDesa = [];
            desaDropDownValue = 0;
            listDesa.add(Desas(id: 0, kecamatanId: 0, name: "Desa"));

            listKec.forEach((e) {
              if (e.id == newValue) {
                listDesa.addAll(e.desas);
              }
            });
          });
        },
      ),
    );
  }

  Widget _buildDesa() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<int>(
        value: desaDropDownValue,
        hint: Text("Desa"),
        items: listDesa.map((Desas value) {
          return DropdownMenuItem<int>(
            value: value.id,
            child: new Text(value.name),
          );
        }).toList(),
        onChanged: (newValue) {
          print(newValue);
          setState(() {
            desaDropDownValue = newValue!;
            resDesaId = newValue;
          });
        },
      ),
    );
  }

  TextFormField buildFormField(String hint, String result, TextEditingController controller) {
    return TextFormField(
      controller: controller,
        onSaved: (newValue) => result = newValue!,
        validator: (value) {
          if (value!.isEmpty) {
            return "gak boleh kosong bro";
          }
          return null;
        },
        decoration: inputForm(hint, hint));
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

}
