part of 'periksa_kebuntingan_bloc.dart';

abstract class PeriksaKebuntinganEvent extends Equatable {}

class PeriksaKebuntinganFetchDataEvent extends PeriksaKebuntinganEvent {
  @override
  List<Object> get props => [];
}

class PeriksaKebuntinganStoreEvent extends PeriksaKebuntinganEvent {
  final PeriksaKebuntingan periksaKebuntingan;

  PeriksaKebuntinganStoreEvent({required this.periksaKebuntingan});

  @override
  List<Object> get props => [];
}
class PeriksaKebuntinganUpdateEvent extends PeriksaKebuntinganEvent {
  final PeriksaKebuntingan periksaKebuntingan;

  PeriksaKebuntinganUpdateEvent({required this.periksaKebuntingan});

  @override
  List<Object> get props => [];
}
class PeriksaKebuntinganDeleteEvent extends PeriksaKebuntinganEvent {
  final PeriksaKebuntingan periksaKebuntingan;

  PeriksaKebuntinganDeleteEvent({required this.periksaKebuntingan});

  @override
  List<Object> get props => [];
}
