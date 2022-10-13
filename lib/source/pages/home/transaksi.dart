import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/data/cubit/proses_transaksi_cubit.dart';
import 'package:flutter_absen_koin/source/pages/home/proses_transaksi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_widget/ticket_widget.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  TextEditingController controllerBarcode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<ProsesTransaksiCubit>(context).compareTanggal(202009016);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0XFFFF884B),
        title: Text(
          "Kantin / Koperasi",
          style: GoogleFonts.lato(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.circleXmark,
              color: Colors.black,
              size: 25,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   "Scan Barcode Karyawan",
                //   style: GoogleFonts.lato(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
                // ),
                // const SizedBox(height: 8),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: controllerBarcode,
                    autofocus: true,
                    // cursorColor:Colors.white,
                    style: const TextStyle(
                      fontSize: 20,
                      // color: Colors.white,
                    ),
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      if (value.length >= 9) {
                        BlocProvider.of<ProsesTransaksiCubit>(context).compareTanggal(controllerBarcode.text);
                      }
                    },
                  ),
                ),
                BlocBuilder<ProsesTransaksiCubit, ProsesTransaksiState>(
                  builder: (context, state) {
                    if (state is ProsesTransaksiLoading) {
                      return const SizedBox(
                        height: 60,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is ProsesTransaksiMessage) {
                      return SizedBox(
                          height: 60,
                          child: Text(
                            state.message!,
                          ));
                    }
                    if (state is ProsesTransaksiLoaded == false) {
                      return Container();
                    }
                    var data = (state as ProsesTransaksiLoaded).result;
                    if (data!.isEmpty) {
                      return Container();
                    }
                    var statusKoin = (state as ProsesTransaksiLoaded).statusKoin;
                    var tanggal_penukaran = (state as ProsesTransaksiLoaded).tgl_penukaran;
                    return ticket(
                      data['FullName'],
                      data['jml_koin'].toString(),
                      data['masa_berlaku_min'],
                      data['masa_berlaku_max'],
                      tanggal_penukaran,
                      statusKoin,
                      data['CardIdNo'],
                      data['shift'],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ticket(nama, koin_makan, masa_berlaku, masa_berlaku_akhir, tanggal_penukaran, status_berlaku, barcode, shift) {
    return TicketWidget(
      width: 450,
      height: 450,
      padding: const EdgeInsets.all(18),
      isCornerRounded: true,
      color: Color(0XFFFCF8E8),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: 130.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(width: 1.5, color: Colors.green),
            ),
            child: Center(
              child: Text(
                status_berlaku,
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 17),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Tiket Koin Makan',
              style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Table(
                  columnWidths: const {
                    0: FixedColumnWidth(300),
                  },
                  children: [
                    const TableRow(children: [
                      Text(
                        "Nama",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Text(
                        "Barcode",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        nama,
                       style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        barcode,
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(height: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Koin Makan",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      koin_makan.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Masa Berlaku",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Table(
                      columnWidths: const {
                        0: FixedColumnWidth(100),
                      },
                      children: [
                        TableRow(children: [
                          Text(
                            "Dari",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            masa_berlaku,
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ]),
                        TableRow(children: [
                          Text(
                            "Sampai",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            masa_berlaku_akhir,
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(300),
                  },
                  children: [
                    const TableRow(children: [
                      Text(
                        "Tanggal Penukaran",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Text(
                        "Shift",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        tanggal_penukaran,
                       style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        shift,
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Copyright PT SIPATEX PUTRI LESTARI",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
