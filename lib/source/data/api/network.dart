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
}
