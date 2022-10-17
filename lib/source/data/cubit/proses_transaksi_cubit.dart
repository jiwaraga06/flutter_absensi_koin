import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_absen_koin/source/data/repository/repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'proses_transaksi_state.dart';

class ProsesTransaksiCubit extends Cubit<ProsesTransaksiState> {
  final MyRepository? myRepository;
  ProsesTransaksiCubit({this.myRepository}) : super(ProsesTransaksiInitial());

  void compareTanggal(cardID, pesan, crID) async {
    emit(ProsesTransaksiLoading());
    await Future.delayed(Duration(milliseconds: 650));
    myRepository!.cekKoin(cardID).then((value) async{
      var json = jsonDecode(value.body);
      print(json);
      if (json.length != 0) {
        if (crID == 1) {
          emit(ProsesTransaksiLoaded(result: json[0], statusKoin: pesan, tgl_penukaran: json[0]['waktu_penukaran'], status: 1));
        } else if (crID == 2) {
          emit(ProsesTransaksiLoaded(result: json[0], statusKoin: pesan, tgl_penukaran: json[0]['waktu_penukaran'], status: 2));
        } else if (crID == 3) {
          emit(ProsesTransaksiLoaded(result: json[0], statusKoin: pesan, tgl_penukaran: "-", status: 3));
        } else if (crID == 4) {
          emit(ProsesTransaksiLoaded(result: json[0], statusKoin: pesan, tgl_penukaran: "-", status: 4));
        } else if (crID == 4) {
          emit(ProsesTransaksiLoaded(result: json[0], statusKoin: pesan, tgl_penukaran: "-", status: 9));
        } else if (crID == 9) {
          emit(ProsesTransaksiMessage(message: pesan));
        }
        await Future.delayed(Duration(seconds: 3));
        emit(ProsesTransaksiLoaded(result: [], status: 0, statusKoin: "", tgl_penukaran: ""));
        // var dateTimekoin = json[0]['masa_berlaku_min'];
        // var dateTimekoinAkhir = json[0]['masa_berlaku_max'];
        // DateTime date = DateTime.now();
        // DateTime dateConvertKoin = DateTime.parse(dateTimekoin);
        // DateTime dateConvertKoinAkhir = DateTime.parse(dateTimekoinAkhir);
        // print("Waktu penukaran koin : $date");
        // print("Waktu expired : $dateTimekoin - $dateTimekoinAkhir");
        // var waktuAkhir = date.isBefore(dateConvertKoinAkhir) && date.isAfter(dateConvertKoin);
        // if (date.isBefore(dateConvertKoin)) {
        //   print("sebelum");
        //   emit(ProsesTransaksiLoaded(result: json[0], statusKoin: "Koin Belum Bisa di Gunakan", tgl_penukaran: date.toString()));
        // } else if (waktuAkhir) {
        //   print("di antara");
        //   emit(ProsesTransaksiLoaded(result: json[0], statusKoin: "Koin Dapat di Gunakan", tgl_penukaran: date.toString()));
        // } else if (date.isAfter(dateConvertKoinAkhir)) {
        //   emit(ProsesTransaksiLoaded(result: json[0], statusKoin: "Koin Kadaluwarsa", tgl_penukaran: date.toString()));
        //   print("sesudah");
        // }
      } else {
        emit(ProsesTransaksiMessage(message: "Data tidak ditemukan"));
      }
    });
  }

  void tukarKoin(cardID, shopName) async {
    await Future.delayed(Duration(seconds: 1));
    myRepository!.tukarKoin(cardID, shopName).then((value) {
      var jsonTukar = jsonDecode(value.body);
      print("TUKAR KOIN :  $jsonTukar");
      if (jsonTukar[0]['crID'] == 1) {
        compareTanggal(cardID, "Koin Bisa di Gunakan", jsonTukar[0]['crID']);
      } else if (jsonTukar[0]['crID'] == 2) {
        compareTanggal(cardID, "Koin Sudah di Pakai", jsonTukar[0]['crID']);
      } else if (jsonTukar[0]['crID'] == 3) {
        compareTanggal(cardID, "Koin Belum Bisa di Pakai", jsonTukar[0]['crID']);
      } else if (jsonTukar[0]['crID'] == 4) {
        compareTanggal(cardID, "Koin Kadaluwarsa", jsonTukar[0]['crID']);
      } else if (jsonTukar[0]['crID'] == 9) {
        compareTanggal(cardID, "Karyawan Belum Absen", jsonTukar[0]['crID']);
      }
    });
  }

  void clearData() {
    emit(ProsesTransaksiLoaded(result: [], status: 0, statusKoin: "", tgl_penukaran: ""));
  }
}
