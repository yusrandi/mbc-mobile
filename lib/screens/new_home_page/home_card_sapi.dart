import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbc_mobile/bloc/sapi_bloc/sapi_bloc.dart';
import 'package:mbc_mobile/config/api.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';
import 'package:mbc_mobile/screens/sapi/detail_sapi.dart';
import 'package:mbc_mobile/screens/sapi/form_sapi_screen.dart';
import 'package:mbc_mobile/utils/constants.dart';
import 'package:mbc_mobile/utils/size_config.dart';

class HomeCardSapi extends StatefulWidget {
  final String userId;
  const HomeCardSapi({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomeCardSapi> createState() => _HomeCardSapiState();
}

class _HomeCardSapiState extends State<HomeCardSapi> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SapiBloc(SapiRepositoryImpl()),
      child: HomeCardSapiBody(userId: widget.userId),
    );
  }
}

class HomeCardSapiBody extends StatefulWidget {
  final String userId;

  const HomeCardSapiBody({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeCardSapiBodyState createState() => _HomeCardSapiBodyState();
}

class _HomeCardSapiBodyState extends State<HomeCardSapiBody> {
  late SapiBloc sapiBloc;

  @override
  void initState() {
    sapiBloc = BlocProvider.of(context);

    sapiBloc.add(SapiFetchDataEvent(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SapiBloc, SapiState>(
      builder: (context, state) {
        if (state is SapiLoadedState) {
          return buildList(state.datas);
        } else if (state is SapiErrorState) {
          return buildError(state.msg);
        } else {
          return buildLoading();
        }
      },
    );
  }

  Container buildList(List<Sapi> list) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          // print(Api.imageURL + '/' + list[index].fotoDepan);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailSapiScreen(sapi: list[index])));
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: SizeConfig.screenWidth * 0.75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green[100]),
              child: Stack(children: [
                Positioned(
                  top: 0,
                  bottom: 60,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              Api.imageURL + '/' + list[index].fotoDepan)),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index].eartag,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Text(
                                list[index].kelamin,
                                style:
                                    TextStyle(color: kTextColor, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible:
                              list[index].kelamin == "Betina" ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SapiFormScreen(
                                              sapi: list[index],
                                              userId: widget.userId)))
                                  .then((value) => setState(() {}));
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kSecondaryColor),
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
            ),
          );
        },
      ),
    );
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
