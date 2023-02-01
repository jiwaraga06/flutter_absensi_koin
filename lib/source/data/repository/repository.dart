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

  Future tukarKoin(cardID, shopID, shiftID) async {
    final json = await myNetwork!.tukar(cardID, shopID, shiftID);
    return json;
  }

  Future tukarKantin(cardID, shiftID) async {
    final json = await myNetwork!.tukarKantin(cardID, shiftID);
    return json;
  }

  Future login(userName, userPass) async {
    final json = await myNetwork!.login(userName, userPass);
    return json;
  }

  Future getReport(outletID, tglAwal, tglAkhir) async {
    final json = await myNetwork!.getReport(outletID, tglAwal, tglAkhir);
    return json;
  }

  Future getShift(barcode) async {
    final json = await myNetwork!.getShift(barcode);
    return json;
  }

  Future changePassOutlet(outletID, oldPassword, newPassword) async {
    final json = await myNetwork!.changePassOutlet(outletID, oldPassword, newPassword);
    return json;
  }
}
