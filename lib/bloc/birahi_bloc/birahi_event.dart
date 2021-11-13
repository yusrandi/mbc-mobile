part of 'birahi_bloc.dart';

abstract class BirahiEvent extends Equatable {
  const BirahiEvent();

  @override
  List<Object> get props => [];
}

class BirahiStoreEvent extends BirahiEvent {
  final String result;
  final String notifId;

  BirahiStoreEvent(this.result, this.notifId);
}
