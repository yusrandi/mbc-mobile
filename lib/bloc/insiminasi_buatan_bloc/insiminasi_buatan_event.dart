part of 'insiminasi_buatan_bloc.dart';

abstract class InsiminasiBuatanEvent extends Equatable {}

class InsiminasiBuatanFetchDataEvent extends InsiminasiBuatanEvent {
  @override
  List<Object> get props => [];
}

class InsiminasiBuatanStoreEvent extends InsiminasiBuatanEvent {
  final InsiminasiBuatan insiminasiBuatan;

  InsiminasiBuatanStoreEvent({required this.insiminasiBuatan});

  @override
  List<Object> get props => [];
}
class InsiminasiBuatanUpdateEvent extends InsiminasiBuatanEvent {
  final InsiminasiBuatan insiminasiBuatan;

  InsiminasiBuatanUpdateEvent({required this.insiminasiBuatan});

  @override
  List<Object> get props => [];
}
class InsiminasiBuatanDeleteEvent extends InsiminasiBuatanEvent {
  final InsiminasiBuatan insiminasiBuatan;

  InsiminasiBuatanDeleteEvent({required this.insiminasiBuatan});

  @override
  List<Object> get props => [];
}
