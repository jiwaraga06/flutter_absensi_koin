part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class SplashLoading extends LoginState {}

class SplashLoaded extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginMessage extends LoginState {
  final String? message;

  LoginMessage({this.message});
}
class AuthStatus extends LoginState {
  final String? message;

  AuthStatus({this.message});
}
