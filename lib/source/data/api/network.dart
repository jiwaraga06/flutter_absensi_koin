import 'package:flutter_absen_koin/source/data/api/api.dart';
import 'package:http/http.dart' as http;

class MyNetwork {
  Future cekKoin(cardID) async {
    try {
      var url = Uri.parse(MyApi.cekKoin(cardID));
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print("Error API CEK KOIN : $e");
    }
  }

  Future tukar(cardID, shopID, shiftID) async {
    try {
      var url = Uri.parse(MyApi.tukar(cardID, shopID, shiftID));
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer ${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print("ERROR API TUKAR KOIN : $e");
    }
  }
  Future tukarKantin(cardID, shiftID) async {
    try {
      var url = Uri.parse(MyApi.tukarKantin(cardID, shiftID));
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer ${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print("ERROR API TUKAR KANTIN : $e");
    }
  }

  Future login(userName, userPass) async {
    try {
      var url = Uri.parse(MyApi.login(userName, userPass));
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print("ERROR API LOGIN : $e");
    }
  }

  Future getReport(outletID, tglAwal, tglAkhir) async {
    try {
      var url = Uri.parse(MyApi.getReport(outletID, tglAwal, tglAkhir));
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print("ERROR API Get Report : $e");
    }
  }

  Future getShift(cardID) async {
    try {
      var url = Uri.parse(MyApi.getShift(cardID));
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print("ERROR API Get Report : $e");
    }
  }

  Future changePassOutlet(outletID, oldPassword, newPassword) async {
    try {
      var url = Uri.parse(MyApi.changePassOutlet(outletID, oldPassword, newPassword));
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer ${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print("ERROR API ChangePassOutlet");
    }
  }
}
