import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_absen_koin/source/data/repository/repository.dart';
import 'package:flutter_absen_koin/source/router/string.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final MyRepository? myRepository;
  LoginCubit({this.myRepository}) : super(LoginInitial());

  void splashScreen(context) async {
    emit(SplashLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(SplashLoaded());
    Navigator.pushReplacementNamed(context, LOGIN);
  }

  void submit(context) async {
    Navigator.pushNamed(context, TRANSAKSI);
  }
}
