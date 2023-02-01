import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/data/cubit/generate_pdf_cubit.dart';
import 'package:flutter_absen_koin/source/data/cubit/periode_cubit.dart';
import 'package:flutter_absen_koin/source/pages/pdf/pdfContent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  var resultSearch = [];
  var data = [];
  TextEditingController controllerSearch = TextEditingController();
  DateTimeRange? _selectedDateRange;
  var tanggalAwal, tanggalAkhir;
  var defaultRowsPerPage = 10;
  void show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime.now(),
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0XFFFF884B),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<PeriodeCubit>(context).clear();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Periode "),
        actions: [
          TextButton(
              onPressed: show,
              child: Text(
                'Pilih Periode',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: ListView(
        children: [
          BlocBuilder<PeriodeCubit, PeriodeState>(
            builder: (context, state) {
              if (state is PeriodeLoading) {
                return const SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              }
              if (state is PeriodeLoaded == false) {
                return Container();
              }

              var total = (state as PeriodeLoaded).total;
              List data = (state as PeriodeLoaded).list;
              // resultSearch =data;
              void search(query) {
                query = query.toLowerCase();
                print('QUery: $query');
                data.map((element) {
                  var fullName = element['FullName'].toString().toLowerCase();
                  if (fullName.contains(query)) {
                    var a = resultSearch.where((element) => element['FullName'].toString().toLowerCase().compareTo(query) == fullName.contains(query)).toList();
                    print("A: $a");
                    if (a.isEmpty) {
                      resultSearch.add(element);
                    }
                  }
                }).toList();
                print('Result Search: $resultSearch');
                setState(() {
                  data = resultSearch;
                });
              }

              final DataTableSource pageTable = MyData(pageTable: resultSearch.length != 0 ? resultSearch : data);
              if (data.isEmpty) {
                return Container();
              }
              if (total!.isEmpty) {
                return Container();
              }

              int _currentSortColumn = 0;
              bool _isAscending = true;
              // void sort<T>(Comparable<T> Function(dynamic d) getField, bool asscending) {
              //   data.sort((a, b) {
              //     final aVal = getField(a);
              //     final bVal = getField(b);
              //     return asscending ? Comparable.compare(aVal, bVal) : Comparable.compare(bVal, aVal);
              //   });
              // }
              void _sort<T>(Comparable<T> Function(dynamic d) getField, int columnIndex, bool ascending) {
                // data._sort<T>(getField, ascending);
                data.sort((a, b) {
                  final aVal = getField(a);
                  final bVal = getField(b);
                  return _isAscending ? Comparable.compare(aVal, bVal) : Comparable.compare(bVal, aVal);
                });
                setState(() {
                  _currentSortColumn = columnIndex;
                  _isAscending = ascending;
                });
              }

              int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
              int _rowsPerPage1 = PaginatedDataTable.defaultRowsPerPage;
              var tableItemsCount = data.length;
              // var defaultRowsPerPage = PaginatedDataTable.defaultRowsPerPage;

              var isRowCountLessDefaultRowsPerPage = tableItemsCount < defaultRowsPerPage;
              _rowsPerPage = isRowCountLessDefaultRowsPerPage ? tableItemsCount : defaultRowsPerPage;
              return Container(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 300,
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
                                  "Total Transaksi",
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
                              BlocProvider.of<GeneratePdfCubit>(context).generatePDF(total[0], tanggalAwal, tanggalAkhir, context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                            ),
                            child: Text("Export PDF"),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      margin: const EdgeInsets.all(3.0),
                      child: PaginatedDataTable(
                        // header: Container(
                        //   child: TextFormField(
                        //     controller: controllerSearch,
                        //     onEditingComplete: () {
                        //       print(controllerSearch.text);
                        //       search(controllerSearch.text);
                        //     },
                        //     // onChanged: (value) {
                        //     //   setState(() {
                        //     //     if (value.length == 0) {
                        //     //       // resultSearch.clear();
                        //     //     }
                        //     //     search(value);
                        //     //   });
                        //     // },
                        //     decoration: InputDecoration(
                        //         isDense: true,
                        //         hintText: 'Cari Nama Karyawan',
                        //         prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                        //         suffixIcon: IconButton(
                        //           onPressed: () {
                        //             // search(controllerSearch.text);
                        //             controllerSearch.clear();
                        //             resultSearch.clear();
                        //           },
                        //           icon: Icon(Icons.close),
                        //         ),
                        //         border: OutlineInputBorder(),
                        //         contentPadding: const EdgeInsets.symmetric(vertical: 10)),
                        //   ),
                        // ),
                        horizontalMargin: 10,
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        // rowsPerPage: isRowCountLessDefaultRowsPerPage ? _rowsPerPage : _rowsPerPage1,
                        rowsPerPage: defaultRowsPerPage,
                        // dataRowHeight: 50,
                        showCheckboxColumn: false,
                        onRowsPerPageChanged: (value) {
                          print(value);
                          setState(() {
                            defaultRowsPerPage = value!;
                          });
                        },
                        columns: [
                          DataColumn(label: Text("No")),
                          DataColumn(
                            label: Text("Nama"),
                            // onSort: (int columnIndex, bool ascending) => _sort<String>((dynamic d) => d['FullName'], columnIndex, ascending)
                            // onSort: (columnIndex, _) {
                            //   setState(() {
                            //     print(_isAscending);
                            //     _currentSortColumn = columnIndex;
                            //     if (_isAscending == true) {
                            //       _isAscending = true;
                            //       data.sort((productA, productB) => productB['FullName'].compareTo(productA['FullName']));
                            //     } else {
                            //       _isAscending = false;
                            //       data.sort((productA, productB) => productA['FullName'].compareTo(productB['FullName']));
                            //     }
                            //   });
                            // },
                          ),
                          DataColumn(label: Text("Departemen")),
                          DataColumn(label: Text("Waktu Penukaran")),
                        ],
                        source: pageTable,
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

class MyData extends DataTableSource {
  final List? pageTable;

  MyData({this.pageTable});
  // final List _data = pageTable ;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => pageTable!.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(pageTable![index]['FullName'].toString())),
      DataCell(Text(pageTable![index]["department"])),
      DataCell(Text(pageTable![index]["waktu_penukaran"].toString())),
    ]);
  }
}
