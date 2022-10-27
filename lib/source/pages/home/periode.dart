import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/data/cubit/periode_cubit.dart';
import 'package:flutter_absen_koin/source/pages/pdf/pdfContent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_absen_koin/source/pages/pdf/pdf.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';

class Periode extends StatefulWidget {
  const Periode({super.key});

  @override
  State<Periode> createState() => _PeriodeState();
}

class _PeriodeState extends State<Periode> {
  DateTimeRange? _selectedDateRange;
  var tanggalAwal, tanggalAkhir;
  void show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());
      print(result.end.toString());
      setState(() {
        _selectedDateRange = result;
        tanggalAwal = _selectedDateRange!.start.toString().split(' ')[0];
        tanggalAkhir = _selectedDateRange!.end.toString().split(' ')[0];
      });
      BlocProvider.of<PeriodeCubit>(context).getReport(
        result.start.toString().split(' ')[0],
        result.end.toString().split(' ')[0],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PeriodeCubit>(context).clear();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0XFFFF884B),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Periode "),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: show,
              child: const Text(
                "Pilih Tanggal ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          BlocBuilder<PeriodeCubit, PeriodeState>(
            builder: (context, state) {
              if (state is PeriodeLoading) {
                return const SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is PeriodeLoaded == false) {
                return Container();
              }
              var total = (state as PeriodeLoaded).total;
              if(total!.isEmpty){
                return Container();
              }
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 1.3, spreadRadius: 1.3, offset: Offset(1, 3))]),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 30,
                            color: Colors.blue,
                            child: const Center(
                              child: Text(
                                "Total Periode",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Table(
                            columnWidths: const {
                              0: FixedColumnWidth(120),
                              1: FixedColumnWidth(20),
                            },
                            children: [
                              TableRow(children: [
                                Text(
                                  "Tanggal Awal",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  tanggalAwal,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  "Tanggal Akhir",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  tanggalAkhir,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  "Total",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  ":",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  total[0].toString(),
                                  // "",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              // createPDF(total);
                              // generateExampleDocument(total, tanggalAwal, tanggalAkhir);
                              BlocProvider.of<PeriodeCubit>(context).generatePDF(total[0], tanggalAwal, tanggalAkhir);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                            ),
                            child: Text("Export PDF"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
