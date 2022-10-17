import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_absen_koin/source/data/repository/repository.dart';
import 'package:flutter_absen_koin/source/router/string.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final MyRepository? myRepository;
  LoginCubit({this.myRepository}) : super(LoginInitial());

  void splashScreen(context) async {
    emit(SplashLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(SplashLoaded());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userName = pref.getString("UserName");
    print(userName);
    if (userName == null) {
      Navigator.pushReplacementNamed(context, LOGIN);
    } else {
      Navigator.pushReplacementNamed(context, TRANSAKSI);
    }
  }

  void submit(context, userName, userPass) async {
    myRepository!.login(userName, userPass).then((value) async {
      var json = jsonDecode(value.body);
      print("API LOGIN : $json");
      if (value.statusCode == 200) {
        if (json[0]['Result'] == 1) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("UserName", userName);
          print("Data di Temukan");
          await Future.delayed(Duration(seconds: 1));
          Navigator.pushReplacementNamed(context, TRANSAKSI);
        } else {
          emit(LoginMessage(message: "Data Tidak di Temukan"));
        }
      }
    });
  }

  void getShopName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userName = pref.getString("UserName");
    emit(AuthStatus(message: userName));
  }
  void keluar(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacementNamed(context, LOGIN);
  }
}
