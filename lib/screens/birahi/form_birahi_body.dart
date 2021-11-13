import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/birahi_bloc/birahi_bloc.dart';
import 'package:mbc_mobile/components/default_button.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:mbc_mobile/utils/size_config.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FormBirahiBody extends StatefulWidget {
  final Notifikasi notif;
  const FormBirahiBody({Key? key, required this.notif}) : super(key: key);

  @override
  _FormBirahiBodyState createState() => _FormBirahiBodyState();
}

class _FormBirahiBodyState extends State<FormBirahiBody> {
  bool isResult = true;
  late BirahiBloc birahiBloc;

  @override
  void initState() {
    birahiBloc = BlocProvider.of(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: BlocListener<BirahiBloc, BirahiState>(
        listener: (context, state) {
          print(state);
          if (state is BirahiInitial || state is BirahiLoadingState) {
            EasyLoading.show(status: 'loading');
          } else if (state is BirahiSuccessState) {
            EasyLoading.showSuccess(state.msg);
            EasyLoading.dismiss();
            Navigator.pop(context);
          } else {
            EasyLoading.dismiss();
            Navigator.pop(context);
          }
        },
        child: Column(
          children: [
            Text("Keterangan Cek Birahi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: getProportionateScreenHeight(16)),
            switchTogle(),
            SizedBox(height: getProportionateScreenHeight(16)),
            GestureDetector(
                onTap: () {
                  alertConfirm();
                },
                child: DefaultButton(text: "Submit")),
          ],
        ),
      ),
    );
  }

  ToggleSwitch switchTogle() {
    return ToggleSwitch(
      minWidth: SizeConfig.screenWidth,
      minHeight: 60,
      cornerRadius: 8.0,
      activeBgColors: [
        [Colors.green[800]!],
        [Colors.red[800]!]
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      initialLabelIndex: isResult ? 0 : 1,
      totalSwitches: 2,
      labels: const ['YA', 'TIDAK'],
      radiusStyle: true,
      onToggle: (index) {
        print('switched to: $index');
        setState(() {
          if (index == 0) {
            isResult = true;
          } else {
            isResult = false;
          }
        });
      },
    );
  }

  void alertConfirm() async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Cancel",
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            confirmButtonText: "Yes, Submit",
            type: ArtSweetAlertType.warning));

    // ignore: unnecessary_null_comparison
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      var result = isResult ? 'yes' : 'no';
      birahiBloc.add(BirahiStoreEvent(result, widget.notif.id.toString()));
      return;
    }
  }
}
