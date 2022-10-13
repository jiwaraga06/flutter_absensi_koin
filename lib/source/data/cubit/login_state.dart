part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class SplashLoading extends LoginState {}

class SplashLoaded extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}
