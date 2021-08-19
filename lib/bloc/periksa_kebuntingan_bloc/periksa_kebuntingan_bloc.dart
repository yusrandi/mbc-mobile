import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/models/periksa_kebuntingan_model.dart';
import 'package:mbc_mobile/repositories/periksa_kebuntingan_repo.dart';

part 'periksa_kebuntingan_event.dart';
part 'periksa_kebuntingan_state.dart';

class PeriksaKebuntinganBloc extends Bloc<PeriksaKebuntinganEvent, PeriksaKebuntinganState> {
  final PeriksaKebuntinganRepository repository;

  PeriksaKebuntinganBloc(this.repository) : super(PeriksaKebuntinganInitialState());

  @override
  Stream<PeriksaKebuntinganState> mapEventToState(PeriksaKebuntinganEvent event) async* {
    if (event is PeriksaKebuntinganFetchDataEvent) {
      try {
        yield PeriksaKebuntinganLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.periksaKebuntinganFetchData();
        yield PeriksaKebuntinganLoadedState(data.periksaKebuntingan);
      } catch (e) {
          
      }
    }else if (event is PeriksaKebuntinganStoreEvent) {
      try {
        yield PeriksaKebuntinganLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.periksaKebuntinganStore(event.periksaKebuntingan);
        if (data.responsecode == "1") {
          yield PeriksaKebuntinganSuccessState(data.responsemsg, data.periksaKebuntingan);
        } else {
          yield PeriksaKebuntinganErrorState(data.responsemsg, data.periksaKebuntingan);
        }
      } catch (e) {
          
      }
    }else if (event is PeriksaKebuntinganUpdateEvent) {
      try {
        yield PeriksaKebuntinganLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.periksaKebuntinganUpdate(event.periksaKebuntingan);
        if (data.responsecode == "1") {
          yield PeriksaKebuntinganSuccessState(data.responsemsg, data.periksaKebuntingan);
        } else {
          yield PeriksaKebuntinganErrorState(data.responsemsg, data.periksaKebuntingan);
        }
      } catch (e) {
          
      }
    }else if (event is PeriksaKebuntinganDeleteEvent) {
      try {
        yield PeriksaKebuntinganLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.periksaKebuntinganDelete(event.periksaKebuntingan);
        if (data.responsecode == "1") {
          yield PeriksaKebuntinganSuccessState(data.responsemsg, data.periksaKebuntingan);
        } else {
          yield PeriksaKebuntinganErrorState(data.responsemsg, data.periksaKebuntingan);
        }
      } catch (e) {
      }
    }





  }
}