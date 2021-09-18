import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_event.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_state.dart';
import 'package:mbc_mobile/models/peternak_model.dart';
import 'package:mbc_mobile/repositories/peternak_repo.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/images.dart';

class CardHomePeternak extends StatelessWidget {
  final int userId;
  const CardHomePeternak({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            PeternakBloc(PeternakRepositoryImpl()),
        child: CardHomePeternakBody(userId: userId));
  }
}

class CardHomePeternakBody extends StatefulWidget {
  final int userId;

  const CardHomePeternakBody({Key? key, required this.userId}) : super(key: key);

  @override
  _CardHomePeternakBodyState createState() => _CardHomePeternakBodyState();
}

class _CardHomePeternakBodyState extends State<CardHomePeternakBody> {
  late PeternakBloc peternakBloc;

  @override
  void initState() {
    super.initState();

    peternakBloc = BlocProvider.of(context);
    peternakBloc.add(PeternakFetchDataEvent(userId: widget.userId));

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeternakBloc, PeternakState>(
      listener: (BuildContext context, state) {
        if (state is PeternakInitialState || state is PeternakLoadingState) {
          EasyLoading.show(status: 'loading');
        } else if (state is PeternakErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.msg);
        } else {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PeternakBloc, PeternakState>(
          builder: (BuildContext context, state) {
        if (state is PeternakLoadedState) {
          return buildList(state.datas);
        } else {
          return Container();
        }
      }),
    );
  }

  Container buildList(List<Peternak> list) {
    return Container(
      height: 230,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            var pet = list[index];
            return Container(
              height: 150,
              width: 250,
              margin: EdgeInsets.only(right: 8),
              child: Stack(
                children: [
                  Positioned(
                      top: 50,
                      bottom: 20,
                      left: 20,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 80),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(pet.namaPeternak,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            Text(pet.desa!.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12)),
                            Text(pet.noHp,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12)),
                          ],
                        ),
                      )),
                  Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      child: Image.asset(
                        Images.farmImage,
                        height: 200,
                      )),
                ],
              ),
            );
          }),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
