import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/periksa_kebuntingan_bloc/periksa_kebuntingan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/screens/periksa_kebuntingan/periksa_kebuntingan_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class PeriksaKebuntinganFormBody extends StatefulWidget {
  final PeriksaKebuntingan periksaKebuntingan;

  const PeriksaKebuntinganFormBody({Key? key, required this.periksaKebuntingan})
      : super(key: key);

  @override
  _PeriksaKebuntinganFormBodyState createState() =>
      _PeriksaKebuntinganFormBodyState();
}

class _PeriksaKebuntinganFormBodyState
    extends State<PeriksaKebuntinganFormBody> {
  final _formKey = GlobalKey<FormState>();

  late SapiBloc sapiBloc;
  late PeriksaKebuntinganBloc periksaKebuntinganBloc;

  List<Sapi> listSapi = [];
  int sapiDropdownValue = 0;

  String resTgl = "";
  String resMetode = "";
  String resHasil = "";
  int resSapiId = 0;
  int resId = 0;

  late DateTime date;

  final _resMetode = new TextEditingController();
  final _resHasil = new TextEditingController();

  @override
  void initState() {
    super.initState();

    sapiBloc = BlocProvider.of(context);
    periksaKebuntinganBloc = BlocProvider.of<PeriksaKebuntinganBloc>(context);

    sapiBloc.add(SapiFetchDataEvent());

    if (widget.periksaKebuntingan.id != 0) {
      resId = widget.periksaKebuntingan.id;

      resSapiId = widget.periksaKebuntingan.sapiId;
      sapiDropdownValue = resSapiId;

      resTgl = widget.periksaKebuntingan.waktuPk;

      _resMetode.text = widget.periksaKebuntingan.metode;
      _resHasil.text = widget.periksaKebuntingan.hasil;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeriksaKebuntinganBloc, PeriksaKebuntinganState>(
      listener: (context, state) {
        print(state);
        if (state is PeriksaKebuntinganInitialState ||
            state is PeriksaKebuntinganLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is PeriksaKebuntinganErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PeriksaKebuntinganSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
          Navigator.pop(context);
        }

        reinitField();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pilih Sapi"),
                  loadSapi(),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  Text("Tanggal Pemeriksaan "),
                  GestureDetector(
                    onTap: () {
                      pickDate(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(50),
                      decoration: BoxDecoration(
                          border: Border.all(color: kSecondaryColor, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          resTgl == "" ? "Silahkan Pilih Tanggal " : resTgl,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  Text("Metode Pemeriksaan "),
                  buildFormFieldMetode('Input Metode'),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  Text("Hasil Pemeriksaan "),
                  buildFormFieldHasil('Input Hasil'),
                  SizedBox(height: getProportionateScreenHeight(26)),
                  GestureDetector(
                    onTap: () {
                      KeyboardUtil.hideKeyboard(context);
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (resSapiId != 0) {
                          if (resTgl != "") {
                            PeriksaKebuntingan pk = PeriksaKebuntingan(
                                id: resId,
                                sapiId: resSapiId,
                                waktuPk: resTgl,
                                metode: resMetode,
                                hasil: resHasil);

                            resId == 0
                                ? periksaKebuntinganBloc.add(
                                    PeriksaKebuntinganStoreEvent(
                                        periksaKebuntingan: pk))
                                : periksaKebuntinganBloc.add(
                                    PeriksaKebuntinganUpdateEvent(
                                        periksaKebuntingan: pk));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Harap Memilih Waktu Pemeriksaan')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Harap Memilih Sapi')),
                          );
                        }
                      }
                    },
                    child: DefaultButton(
                      text: "Submit",
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget loadSapi() {
    return BlocBuilder<SapiBloc, SapiState>(builder: (context, state) {
      if (state is SapiInitialState || state is SapiLoadingState) {
        return buildLoading();
      } else if (state is SapiLoadedState) {
        listSapi = [];
        listSapi.add(Sapi(
            id: 0,
            jenisSapiId: 0,
            peternakId: 0,
            ertag: "ertag",
            ertagInduk: "ertagInduk",
            namaSapi: "Nama Sapi",
            tanggalLahir: "tglLahir",
            kelamin: "kelamin",
            kondisiLahir: "kondisiLahir",
            anakKe: "anakKe",
            fotoDepan: "photoDepan",
            fotoBelakang: "photoBelakang",
            fotoKanan: "photoKanan",
            fotoKiri: "photoKiri"));

        listSapi.addAll(state.datas);
        return buildSapi(listSapi);
      } else {
        return buildError(state.toString());
      }
    });
  }

  Container buildSapi(List<Sapi> list) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<int>(
        value: sapiDropdownValue,
        hint: Text("Pilih Sapi"),
        items: list.map((Sapi value) {
          return DropdownMenuItem<int>(
            value: value.id,
            child: new Text(value.namaSapi),
          );
        }).toList(),
        onChanged: (newValue) {
          print(newValue);

          setState(() {
            sapiDropdownValue = newValue!;
            resSapiId = newValue;
          });
        },
      ),
    );
  }

  TextFormField buildFormFieldMetode(String hint) {
    return TextFormField(
        controller: _resMetode,
        onSaved: (newValue) => resMetode = newValue!,
        validator: (value) {
          if (value!.isEmpty) {
            return "gak boleh kosong bro";
          }
          return null;
        },
        decoration: inputForm(hint, hint));
  }

  TextFormField buildFormFieldHasil(String hint) {
    return TextFormField(
        controller: _resHasil,
        onSaved: (newValue) => resHasil = newValue!,
        validator: (value) {
          if (value!.isEmpty) {
            return "gak boleh kosong bro";
          }
          return null;
        },
        decoration: inputForm(hint, hint));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildError(String msg) {
    return Center(
      child: Text(msg,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (newDate == null) return;

    setState(() {
      date = newDate;
      resTgl = DateFormat('yyyy/MM/dd').format(date);
      print(date);
    });
  }

  void reinitField() {
    setState(() {
      resId = 0;
      resSapiId = 0;
      sapiDropdownValue = 0;
      resHasil = "";
      resMetode = "";
      resTgl = "";
      _resMetode.text = "";
      _resHasil.text = "";
    });
  }
}
