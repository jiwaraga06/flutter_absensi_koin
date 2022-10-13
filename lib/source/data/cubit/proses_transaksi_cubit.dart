import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_absen_koin/source/data/repository/repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'proses_transaksi_state.dart';

class ProsesTransaksiCubit extends Cubit<ProsesTransaksiState> {
  final MyRepository? myRepository;
  ProsesTransaksiCubit({this.myRepository}) : super(ProsesTransaksiInitial());

  void compareTanggal(cardID) async {
    emit(ProsesTransaksiLoading());
    await Future.delayed(Duration(seconds: 1));
    myRepository!.cekKoin(cardID).then((value) {
      var json = jsonDecode(value.body);
      print(json);
      if (json.length != 0) {
        // emit(ProsesTransaksiLoaded(result: json[0]));
        var dateTimekoin = json[0]['masa_berlaku_min'];
        var dateTimekoinAkhir = json[0]['masa_berlaku_max'];
        DateTime date = DateTime.now();
        DateTime dateConvertKoin = DateTime.parse(dateTimekoin);
        DateTime dateConvertKoinAkhir = DateTime.parse(dateTimekoinAkhir);
        print("Waktu penukaran koin : $date");
        print("Waktu expired : $dateTimekoin - $dateTimekoinAkhir");
        var waktuAkhir = date.isBefore(dateConvertKoinAkhir) && date.isAfter(dateConvertKoin);
        if (date.isBefore(dateConvertKoin)) {
          print("sebelum");
          emit(ProsesTransaksiLoaded(result: json[0], statusKoin: "Koin Belum Bisa di Gunakan", tgl_penukaran: date.toString()));
        } else if (waktuAkhir) {
          print("di antara");
          emit(ProsesTransaksiLoaded(result: json[0], statusKoin: "Koin Berlaku", tgl_penukaran: date.toString()));
        } else if (date.isAfter(dateConvertKoinAkhir)) {
          emit(ProsesTransaksiLoaded(result: json[0], statusKoin: "Koin Kadaluwarsa", tgl_penukaran: date.toString()));
          print("sesudah");
        }
      } else {
        emit(ProsesTransaksiMessage(message: "Data tidak ditemukan"));
      }
    });
  }
}
