import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_absen_koin/source/data/repository/repository.dart';
import 'package:flutter_absen_koin/source/router/string.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_pass_state.dart';

class ChangePassCubit extends Cubit<ChangePassState> {
  // 201105009
  final MyRepository? myRepository;
  ChangePassCubit({this.myRepository}) : super(ChangePassInitial());
  void changePasOutlet(context, oldPassword, newPassword) async {
    emit(ChangePassLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var outletID = pref.getInt("ShopID");
    myRepository!.changePassOutlet(outletID, oldPassword, newPassword).then((value) async{
      var json = jsonDecode(value.body);
      print("Result Change Pass: $json");
      if (json[0]['Result'] == 1) {
        emit(ChangePassLoaded(result: json));
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        keluar(context);
      } else {
        emit(ChangePassLoaded(result: json));
      }
    });
  }

  void keluar(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacementNamed(context, LOGIN);
  }
}
