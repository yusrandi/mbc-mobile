import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mbc_mobile/bloc/notif_bloc/notifikasi_bloc.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:mbc_mobile/repositories/notifikasi_repo.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomeScreenTodo extends StatelessWidget {
  final int id;

  const HomeScreenTodo({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            NotifikasiBloc(NotifikasiRepositoryImpl()),
        child: TodoScreenBody(id: id));
  }
}

class TodoScreenBody extends StatefulWidget {
  final int id;

  const TodoScreenBody({Key? key, required this.id}) : super(key: key);

  @override
  _TodoScreenBodyState createState() => _TodoScreenBodyState();
}

class _TodoScreenBodyState extends State<TodoScreenBody> {
  late NotifikasiBloc notifikasiBloc;

  @override
  void initState() {
    notifikasiBloc = BlocProvider.of<NotifikasiBloc>(context);
    notifikasiBloc.add(NotifFetchByUserId(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotifikasiBloc, NotifikasiState>(
        listener: (context, state) {
      if (state is NotifikasiInitialState || state is NotifikasiLoadingState) {
        EasyLoading.show(status: 'loading');
      } else if (state is NotifikasiErrorState) {
        EasyLoading.dismiss();
        EasyLoading.showError(state.error);
      } else {
        EasyLoading.dismiss();
      }
    }, child: BlocBuilder<NotifikasiBloc, NotifikasiState>(
      builder: (BuildContext context, state) {
        if (state is NotifikasiSuccessState) {
          return builList(state.datas.notifikasi);
        } else {
          return Container();
        }
      },
    ));
  }

  Container builList(List<Notifikasi> list) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            var notif = list[index];
            return Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child:
                            Icon(FontAwesomeIcons.circle, color: kPrimaryColor),
                      ),
                      Container(
                        width: 3,
                        height: 100,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Expanded(
                      child: Container(
                    height: getProportionateScreenHeight(130),
                    margin: EdgeInsets.only(left: 5),
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notif.sapi!.ertag,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: getProportionateScreenHeight(16)),
                        Text(notif.tanggal,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text(notif.pesan,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )),
                ],
              ),
            );
          }),
    );
  }
}
