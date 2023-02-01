part of 'periode_cubit.dart';

@immutable
abstract class PeriodeState {}

class PeriodeInitial extends PeriodeState {}

class PeriodeLoading extends PeriodeState {}

class PeriodeLoaded extends PeriodeState {
  final dynamic list;
  final dynamic total;

  PeriodeLoaded({this.total, this.list});
}
