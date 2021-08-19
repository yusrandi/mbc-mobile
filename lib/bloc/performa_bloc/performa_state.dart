part of 'performa_bloc.dart';

abstract class PerformaState extends Equatable {}

class PerformaInitialState extends PerformaState {
  @override
  List<Object> get props => [];
}

class PerformaLoadingState extends PerformaState {
  @override
  List<Object> get props => [];
}

class PerformaSuccessState extends PerformaState {
  final String msg;
  final List<Performa> datas;

  PerformaSuccessState(this.msg, this.datas);

  @override
  List<Object> get props => [];
}
class PerformaErrorState extends PerformaState {
  final String msg;
  final List<Performa> datas;

  PerformaErrorState(this.msg, this.datas);

  @override
  List<Object> get props => [];
}
class PerformaLoadedState extends PerformaState {
  final List<Performa> datas;
  PerformaLoadedState(this.datas);
  @override
  List<Object> get props => [];
}
