part of 'perlakuan_bloc.dart';

abstract class PerlakuanEvent extends Equatable {}

class PerlakuanFetchDataEvent extends PerlakuanEvent {
  @override
  List<Object> get props => [];
}

class PerlakuanStoreEvent extends PerlakuanEvent {
  final Perlakuan perlakuan;

  PerlakuanStoreEvent({required this.perlakuan});

  @override
  List<Object> get props => [];
}
class PerlakuanUpdateEvent extends PerlakuanEvent {
  final Perlakuan perlakuan;

  PerlakuanUpdateEvent({required this.perlakuan});

  @override
  List<Object> get props => [];
}
class PerlakuanDeleteEvent extends PerlakuanEvent {
  final Perlakuan perlakuan;

  PerlakuanDeleteEvent({required this.perlakuan});

  @override
  List<Object> get props => [];
}
