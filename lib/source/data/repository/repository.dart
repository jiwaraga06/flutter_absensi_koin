import 'package:flutter_absen_koin/source/data/api/api.dart';
import 'package:flutter_absen_koin/source/data/api/network.dart';
import 'package:http/http.dart' as http;

class MyRepository {
  final MyNetwork? myNetwork;

  MyRepository({required this.myNetwork});

  Future cekKoin(cardID) async {
    final json = await myNetwork!.cekKoin(cardID);
    return json;
  }
}
