import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/perlakuan_bloc/perlakuan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class PerlakuanFormBody extends StatefulWidget {
  final Perlakuan perlakuan;

  const PerlakuanFormBody({Key? key, required this.perlakuan})
      : super(key: key);

  @override
  _PerlakuanFormBodyState createState() => _PerlakuanFormBodyState();
}

class _PerlakuanFormBodyState extends State<PerlakuanFormBody> {
  final _formKey = GlobalKey<FormState>();

  late SapiBloc sapiBloc;
  late PerlakuanBloc perlakuanBloc;

  List<Sapi> listSapi = [];
  int sapiDropdownValue = 0;

  int resSapiId = 0;
  int resId = 0;
  String resTgl = "";

  late DateTime date;

  final _resObatJenis = new TextEditingController();
  final _resObatDosis = new TextEditingController();
  final _resVaksin = new TextEditingController();
  final _resVaksinDosis = new TextEditingController();
  final _resVitamin = new TextEditingController();
  final _resVitaminDosis = new TextEditingController();
  final _resHormon = new TextEditingController();
  final _resHormonDosis = new TextEditingController();
  final _resKeterangan = new TextEditingController();

  @override
  void initState() {
    super.initState();

    sapiBloc = BlocProvider.of<SapiBloc>(context);
    perlakuanBloc = BlocProvider.of<PerlakuanBloc>(context);

    sapiBloc.add(SapiFetchDataEvent());

    if (widget.perlakuan.id != 0) {
      resId = widget.perlakuan.id;

      resSapiId = widget.perlakuan.sapiId;
      sapiDropdownValue = resSapiId;

      resTgl = widget.perlakuan.tglPerlakuan;

      _resObatJenis.text = widget.perlakuan.jenisObat.toString();
      _resObatDosis.text = widget.perlakuan.dosisObat.toString();
      _resVaksin.text = widget.perlakuan.vaksin.toString();
      _resVaksinDosis.text = widget.perlakuan.dosisVaksin.toString();
      _resVitamin.text = widget.perlakuan.vitamin.toString();
      _resVitaminDosis.text = widget.perlakuan.dosisVitamin.toString();
      _resHormon.text = widget.perlakuan.hormon.toString();
      _resHormonDosis.text = widget.perlakuan.dosisHormon.toString();
      _resKeterangan.text = widget.perlakuan.ketPerlakuan.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PerlakuanBloc, PerlakuanState>(
      listener: (context, state) {
        print(state);
        if (state is PerlakuanInitialState || state is PerlakuanLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is PerlakuanErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PerlakuanSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();

          Navigator.pop(context);
        }
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
                Text("Tanggal Perlakuan "),
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
                Text("Jenis Obat "),
                buildFormField(
                    'ex : Paracetamol', _resObatJenis, TextInputType.text),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Dosis Obat "),
                buildFormField('ex : 100', _resObatDosis, TextInputType.number),
                SizedBox(height: getProportionateScreenHeight(16)),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Jenis Vaksin "),
                buildFormField('ex : Synopak', _resVaksin, TextInputType.text),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Dosis Vaksin "),
                buildFormField(
                    'ex : 100', _resVaksinDosis, TextInputType.number),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Jenis Vitamin "),
                buildFormField('ex : A/B/C', _resVitamin, TextInputType.text),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Dosis Vitamin "),
                buildFormField(
                    'ex : 100', _resVitaminDosis, TextInputType.number),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Jenis Hormon "),
                buildFormField('ex : Oxytoxin', _resHormon, TextInputType.text),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Dosis Hormon "),
                buildFormField(
                    'ex : 100', _resHormonDosis, TextInputType.number),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Keterangan Perlakuan "),
                buildFormField('ex : Input Keterangan Perlakuan',
                    _resKeterangan, TextInputType.text),
                SizedBox(height: getProportionateScreenHeight(16)),
                SizedBox(height: getProportionateScreenHeight(32)),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      if (resSapiId != 0) {
                        if (resTgl != "") {
                          Perlakuan perlakuan = Perlakuan(
                              id: resId,
                              sapiId: resSapiId,
                              tglPerlakuan: resTgl,
                              jenisObat: _resObatJenis.text.trim(),
                              dosisObat: int.parse(_resObatDosis.text.trim()),
                              vaksin: _resVaksin.text.trim(),
                              dosisVaksin:
                                  int.parse(_resVaksinDosis.text.trim()),
                              vitamin: _resVitamin.text.trim(),
                              dosisVitamin:
                                  int.parse(_resVitaminDosis.text.trim()),
                              hormon: _resHormon.text.trim(),
                              dosisHormon:
                                  int.parse(_resHormonDosis.text.trim()),
                              ketPerlakuan: _resKeterangan.text.trim());

                          resId == 0
                              ? perlakuanBloc.add(
                                  PerlakuanStoreEvent(perlakuan: perlakuan))
                              : perlakuanBloc.add(
                                  PerlakuanUpdateEvent(perlakuan: perlakuan));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Pilih Tanggal dulu')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pilih sapi dulu')));
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

  TextFormField buildFormField(
      String hint, TextEditingController controller, TextInputType inputType) {
    return TextFormField(
        keyboardType: inputType,
        controller: controller,
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
}
