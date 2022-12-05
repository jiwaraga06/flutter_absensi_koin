part of 'change_pass_cubit.dart';

@immutable
abstract class ChangePassState {}

class ChangePassInitial extends ChangePassState {}

class ChangePassLoading extends ChangePassState {}

class ChangePassLoaded extends ChangePassState {
  final dynamic result;

  ChangePassLoaded({this.result});
}

class ChangePassMessage extends ChangePassState{
  final String? message;

  ChangePassMessage({this.message});
}
