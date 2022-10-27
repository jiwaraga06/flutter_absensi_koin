import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_absen_koin/source/data/repository/repository.dart';
import 'package:flutter_absen_koin/source/pages/pdf/pdfContent.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'periode_state.dart';

class PeriodeCubit extends Cubit<PeriodeState> {
  final MyRepository? myRepository;
  PeriodeCubit({this.myRepository}) : super(PeriodeInitial());

  void getReport(tglAwal, tglAkhir) async {
    emit(PeriodeLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var outletID = pref.getInt("ShopID");
    myRepository!.getReport(outletID, tglAwal, tglAkhir).then((value) {
      var json = jsonDecode(value.body);
      print("List Periode: $json");
      List<int> total = [];
      json.map((e) {
        total.add(e['jml_koin']);
      }).toList();
      print(total);
      var sum = total.fold(0, (a, b) => a + b);
      print(sum);
      // emit(PeriodeTotal(total: sum));
      emit(PeriodeLoaded(total: [sum]));
    });
  }

  void generatePDF(total, tglAwal, tglAkhir) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var shopID = pref.getString("UserName");
    final path = (await getExternalStorageDirectory())!.path;
    final targetPath = path;
    final targetFileName = "Report Koin $tglAwal - $tglAkhir";
    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
      PDFVIEW.htmlContent(total, tglAwal, tglAkhir, shopID),
      targetPath,
      targetFileName,
    );
    print(generatedPdfFile.uri);
  }

  void clear() {
    emit(PeriodeLoaded( total: []));
  }
}
