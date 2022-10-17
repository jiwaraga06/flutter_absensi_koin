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

  Future tukar(cardID, shopName) async {
    try {
      var url = Uri.parse(MyApi.tukar(cardID, shopName));
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer ${MyApi.token()}'},
      );
      return response;
    } catch (e) {
      print("ERROR API TUKAR KOIN : $e");
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
}
