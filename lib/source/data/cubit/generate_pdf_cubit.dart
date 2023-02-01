import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/pages/pdf/pdfContent.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'generate_pdf_state.dart';

class GeneratePdfCubit extends Cubit<GeneratePdfState> {
  GeneratePdfCubit() : super(GeneratePdfInitial());
  void generatePDF(total, tglAwal, tglAkhir, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var shopID = pref.getString("UserName");
    // final path = (await getExternalStorageDirectory())!.path;
    Directory path = Directory('/storage/emulated/0/Download');
    final targetPath = path;
    final targetFileName = "Report Koin $tglAwal - $tglAkhir";
    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
      PDFVIEW.htmlContent(total, tglAwal, tglAkhir, shopID),
      targetPath.path,
      targetFileName,
    );
    print(generatedPdfFile.uri);
    if (generatedPdfFile.uri != false) {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
              height: 50.0,
              color: Colors.green,
              child: Center(
                child: Text('Barhasil Export PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            );
          });
    }
  }
}
