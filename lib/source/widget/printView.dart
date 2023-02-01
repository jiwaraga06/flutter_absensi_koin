import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ticket_widget/ticket_widget.dart';

buildPrintView() {
  pw.Container(
    // width: 450,
    // height: 550,
    padding: const pw.EdgeInsets.all(18),
    child: pw.Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pw.Container(
          // width: 130.0,
          height: 40.0,
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(30.0),
            border: pw.Border.all(
              width: 1.5,
              // color: pw.Colors.black,
            ),
          ),
          child: pw.Center(
            child: pw.Text(
              'status_berlaku',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 17),
            ),
          ),
        ),
        pw.Padding(
          padding: pw.EdgeInsets.only(top: 20.0),
          child: pw.Text(
            'Tiket Koin Makan',
            style: pw.TextStyle(fontSize: 20.0, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Padding(
          padding: pw.EdgeInsets.only(left: 12.0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Table(
                columnWidths: const {
                  0: pw.FixedColumnWidth(300),
                },
                children: [
                  pw.TableRow(children: [
                    pw.Text(
                      "Nama",
                      style: pw.TextStyle(fontSize: 15),
                    ),
                    pw.Text(
                      "Barcode",
                      style: pw.TextStyle(fontSize: 15),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Text(
                      'nama',
                      maxLines: 2,
                      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      'barcode',
                      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                  ]),
                ],
              ),
              pw.SizedBox(height: 14),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    "Koin Makan",
                    style: pw.TextStyle(fontSize: 15),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'koin_makan',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
              pw.SizedBox(height: 14),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    "Masa Berlaku",
                    style: pw.TextStyle(fontSize: 15),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Table(
                    columnWidths: const {
                      0: pw.FixedColumnWidth(100),
                    },
                    children: [
                      pw.TableRow(children: [
                        pw.Text(
                          "Dari",
                          style: pw.TextStyle(fontSize: 15),
                        ),
                        pw.Text(
                          'masa_berlaku',
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          "Sampai",
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        pw.Text(
                          'masa_berlaku_akhir',
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                columnWidths: const {
                  0: pw.FixedColumnWidth(300),
                },
                children: [
                  pw.TableRow(children: [
                    pw.Text(
                      "Tanggal Penukaran",
                      style: pw.TextStyle(fontSize: 15),
                    ),
                    pw.Text(
                      "Shift",
                      style: pw.TextStyle(fontSize: 15),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Text(
                      'tanggal_penukaran',
                      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      'shift',
                      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                  ]),
                ],
              ),
              pw.SizedBox(height: 14),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    "Tempat Penukaran",
                    style: pw.TextStyle(fontSize: 15),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    "Kantin",
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 50),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              "Copyright PT SIPATEX PUTRI LESTARI",
              style: pw.TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    ),
  );
}
