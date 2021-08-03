import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_event.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_state.dart';
import 'package:mbc_mobile/repositories/peternak_repo.dart';

class PeternakBloc extends Bloc<PeternakEvent, PeternakState> {
  final PeternakRepository repository;

  PeternakBloc(this.repository) : super(PeternakInitialState());

  @override
  Stream<PeternakState> mapEventToState(PeternakEvent event) async* {
    if (event is PeternakFetchDataEvent) {
      try {
        yield PeternakLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.PeternakFetchData();
        yield PeternakLoadedState(data.peternak);
      } catch (e) {}
    }else if (event is PeternakStoreEvent) {
      try {
        yield PeternakLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.peternakStore(event.peternak);
        if (data.responsecode == "1") {
          yield PeternakSuccessState(data.responsemsg, data.peternak);
        } else {
          yield PeternakErrorState(data.responsemsg, data.peternak);
        }
      } catch (e) {}
    }else if (event is PeternakUpdateEvent) {
      try {
        yield PeternakLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.peternakUpdate(event.peternak);
        if (data.responsecode == "1") {
          yield PeternakSuccessState(data.responsemsg, data.peternak);
        } else {
          yield PeternakErrorState(data.responsemsg, data.peternak);
        }
      } catch (e) {}
    }else if (event is PeternakDeleteEvent) {
      try {
        yield PeternakLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.peternakDelete(event.peternak);
        if (data.responsecode == "1") {
          yield PeternakSuccessState(data.responsemsg, data.peternak);
        } else {
          yield PeternakErrorState(data.responsemsg, data.peternak);
        }
      } catch (e) {}
    }





  }
}