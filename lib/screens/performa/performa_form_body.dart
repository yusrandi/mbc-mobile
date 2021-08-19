import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/performa_bloc/performa_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/performa_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/screens/performa/performa_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class PerformaFormBody extends StatefulWidget {
  final Performa performa;

  const PerformaFormBody({Key? key, required this.performa}) : super(key: key);

  @override
  _PerformaFormBodyState createState() => _PerformaFormBodyState();
}

class _PerformaFormBodyState extends State<PerformaFormBody> {
  final _formKey = GlobalKey<FormState>();

  late SapiBloc sapiBloc;
  late PerformaBloc performaBloc;

  List<Sapi> listSapi = [];
  int sapiDropdownValue = 0;

  int resSapiId = 0;
  int resId = 0;
  String resTgl = "";

  late DateTime date;

  final _resTinggi = new TextEditingController();
  final _resBerat = new TextEditingController();
  final _resPanjang = new TextEditingController();
  final _resLingkar = new TextEditingController();
  final _resBSC = new TextEditingController();

  @override
  void initState() {
    super.initState();

    sapiBloc = BlocProvider.of<SapiBloc>(context);
    performaBloc = BlocProvider.of<PerformaBloc>(context);

    sapiBloc.add(SapiFetchDataEvent());

    if (widget.performa.id != 0) {
      resId = widget.performa.id;

      resSapiId = widget.performa.sapiId;
      sapiDropdownValue = resSapiId;

      resTgl = widget.performa.tanggalPerforma;

      _resTinggi.text = widget.performa.tinggiBadan.toString();
      _resBerat.text = widget.performa.beratBadan.toString();
      _resPanjang.text = widget.performa.panjangBadan.toString();
      _resLingkar.text = widget.performa.lingkarDada.toString();
      _resBSC.text = widget.performa.bsc.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PerformaBloc, PerformaState>(
      listener: (context, state){
         print(state);
        if (state is PerformaInitialState ||
            state is PerformaLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is PerformaErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is PerformaSuccessState) {
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
                Text("Tinggi Badan "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resTinggi)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("cm", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Berat Badan "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resBerat)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("cm", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Panjang Badan "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resPanjang)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("cm", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Lingkar Dada "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resLingkar)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("cm", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("BSC "),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: buildFormField('ex : 100', _resBSC)),
                  SizedBox(width: getProportionateScreenWidth(16)),
                  Text("cm", style: TextStyle(fontSize: 20)),
                ]),
                SizedBox(height: getProportionateScreenHeight(32)),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      if (resSapiId != 0) {
                        if (resTgl != "") {
                          Performa performa = Performa(
                              id: resId,
                              sapiId: resSapiId,
                              tanggalPerforma: resTgl,
                              tinggiBadan: int.parse(_resTinggi.text.trim()),
                              beratBadan: int.parse(_resBerat.text.trim()),
                              panjangBadan: int.parse(_resPanjang.text.trim()),
                              lingkarDada: int.parse(_resLingkar.text.trim()),
                              bsc: int.parse(_resBSC.text.trim()));
    
                          resId == 0
                              ? performaBloc
                                  .add(PerformaStoreEvent(performa: performa))
                              : performaBloc
                                  .add(PerformaUpdateEvent(performa: performa));
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

  TextFormField buildFormField(String hint, TextEditingController controller) {
    return TextFormField(
        keyboardType: TextInputType.number,
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
