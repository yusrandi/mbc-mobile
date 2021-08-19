part of 'perlakuan_bloc.dart';

abstract class PerlakuanState extends Equatable {}

class PerlakuanInitialState extends PerlakuanState {
  @override
  List<Object> get props => [];
}

class PerlakuanLoadingState extends PerlakuanState {
  @override
  List<Object> get props => [];
}

class PerlakuanSuccessState extends PerlakuanState {
  final String msg;
  final List<Perlakuan> datas;

  PerlakuanSuccessState(this.msg, this.datas);

  @override
  List<Object> get props => [];
}
class PerlakuanErrorState extends PerlakuanState {
  final String msg;
  final List<Perlakuan> datas;

  PerlakuanErrorState(this.msg, this.datas);

  @override
  List<Object> get props => [];
}
class PerlakuanLoadedState extends PerlakuanState {
  final List<Perlakuan> datas;
  PerlakuanLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
