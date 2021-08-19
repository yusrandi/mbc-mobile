import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';

part 'sapi_event.dart';
part 'sapi_state.dart';

class SapiBloc extends Bloc<SapiEvent, SapiState> {
  final SapiRepository repository;

  SapiBloc(this.repository) : super(SapiInitialState());

  @override
  Stream<SapiState> mapEventToState(SapiEvent event) async* {
    if (event is SapiFetchDataEvent) {
      try {
        yield SapiLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.sapiFetchData();
        yield SapiLoadedState(data.sapi);
      } catch (e) {}
    }
  }
}
