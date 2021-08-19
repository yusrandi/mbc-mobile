part of 'performa_bloc.dart';

abstract class PerformaEvent extends Equatable {}

class PerformaFetchDataEvent extends PerformaEvent {
  @override
  List<Object> get props => [];
}

class PerformaStoreEvent extends PerformaEvent {
  final Performa performa;

  PerformaStoreEvent({required this.performa});

  @override
  List<Object> get props => [];
}
class PerformaUpdateEvent extends PerformaEvent {
  final Performa performa;

  PerformaUpdateEvent({required this.performa});

  @override
  List<Object> get props => [];
}
class PerformaDeleteEvent extends PerformaEvent {
  final Performa performa;

  PerformaDeleteEvent({required this.performa});

  @override
  List<Object> get props => [];
}
