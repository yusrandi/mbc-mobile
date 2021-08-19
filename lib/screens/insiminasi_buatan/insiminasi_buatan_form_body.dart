import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mbc_mobile/bloc/insiminasi_buatan_bloc/insiminasi_buatan_bloc.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/bloc/strow_bloc/strow_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/helper/keyboard.dart';
import 'package:mbc_mobile/models/insiminasi_buatan_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/models/strow_model.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:mbc_mobile/utils/theme.dart';

class InsiminasiBuatanFormBody extends StatefulWidget {
  final InsiminasiBuatan insiminasiBuatan;

  const InsiminasiBuatanFormBody({Key? key, required this.insiminasiBuatan})
      : super(key: key);

  @override
  _InsiminasiBuatanFormBodyState createState() =>
      _InsiminasiBuatanFormBodyState();
}

class _InsiminasiBuatanFormBodyState extends State<InsiminasiBuatanFormBody> {
  final _formKey = GlobalKey<FormState>();

  late SapiBloc sapiBloc;
  late StrowBloc strowBloc;
  late InsiminasiBuatanBloc insiminasiBuatanBloc;

  List<Sapi> listSapi = [];
  List<Strow> listStrow = [];

  int sapiDropdownValue = 0;
  int strowDropdownValue = 0;

  int resSapiId = 0;
  int resStrowId = 0;
  int resId = 0;
  String resTgl = "";

  final _resDosis = new TextEditingController();

  @override
  void initState() {
    super.initState();

    sapiBloc = BlocProvider.of<SapiBloc>(context);
    strowBloc = BlocProvider.of<StrowBloc>(context);
    insiminasiBuatanBloc = BlocProvider.of<InsiminasiBuatanBloc>(context);

    sapiBloc.add(SapiFetchDataEvent());
    strowBloc.add(StrowFetchDataEvent());

    if (widget.insiminasiBuatan.id != 0) {
      resId = widget.insiminasiBuatan.id;

      resSapiId = widget.insiminasiBuatan.sapiId;
      resStrowId = widget.insiminasiBuatan.strowId;
      resTgl = widget.insiminasiBuatan.waktuIb;
      sapiDropdownValue = resSapiId;
      strowDropdownValue = resStrowId;

      _resDosis.text = widget.insiminasiBuatan.dosisIb.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InsiminasiBuatanBloc, InsiminasiBuatanState>(
      listener: (context, state) {
        print(state);
        if (state is InsiminasiBuatanInitialState ||
            state is InsiminasiBuatanLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is InsiminasiBuatanErrorState) {
          EasyLoading.showError(state.msg);
          EasyLoading.dismiss();
        } else if (state is InsiminasiBuatanSuccessState) {
          EasyLoading.showSuccess(state.msg);
          EasyLoading.dismiss();
          Navigator.pop(context, true);
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
                Text("Pilih Strow"),
                loadStrow(),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text("Pilih Tanggal"),
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
                Text("Dosis IB "),
                buildFormField('Input Kode Batch', _resDosis),
                SizedBox(height: getProportionateScreenHeight(36)),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      if (resSapiId != 0) {
                        InsiminasiBuatan insiminasiBuatan = InsiminasiBuatan(
                            id: resId,
                            waktuIb: resTgl,
                            sapiId: resSapiId,
                            strowId: resStrowId,
                            dosisIb: int.parse(_resDosis.text.trim()));

                        resId == 0
                            ? insiminasiBuatanBloc.add(
                                InsiminasiBuatanStoreEvent(
                                    insiminasiBuatan: insiminasiBuatan))
                            : insiminasiBuatanBloc.add(
                                InsiminasiBuatanUpdateEvent(
                                    insiminasiBuatan: insiminasiBuatan));
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

  Widget loadStrow() {
    return BlocBuilder<StrowBloc, StrowState>(builder: (context, state) {
      if (state is StrowInitialState || state is StrowLoadingState) {
        return buildLoading();
      } else if (state is StrowLoadedState) {
        listStrow = [];
        listStrow.add(
            Strow(id: 0, sapiId: 0, kodeBatch: "Pilih Strow", batch: "batch"));

        listStrow.addAll(state.datas);
        return buildStrow(listStrow);
      } else {
        return buildError(state.toString());
      }
    });
  }

  Container buildStrow(List<Strow> list) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<int>(
        value: strowDropdownValue,
        hint: Text("Pilih Strow"),
        items: list.map((Strow value) {
          return DropdownMenuItem<int>(
            value: value.id,
            child: new Text(value.kodeBatch),
          );
        }).toList(),
        onChanged: (newValue) {
          print(newValue);

          setState(() {
            strowDropdownValue = newValue!;
            resStrowId = newValue;
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

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (newDate == null) return;

    setState(() {
      resTgl = DateFormat('yyyy/MM/dd').format(newDate);
    });
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
}
