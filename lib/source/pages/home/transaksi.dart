import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/data/cubit/login_cubit.dart';
import 'package:flutter_absen_koin/source/data/cubit/proses_transaksi_cubit.dart';
import 'package:flutter_absen_koin/source/pages/home/proses_transaksi.dart';
import 'package:flutter_absen_koin/source/router/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:ticket_widget/ticket_widget.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  TextEditingController controllerBarcode = TextEditingController();
  TextEditingController controllerLogout = TextEditingController();
  final formkey = GlobalKey<FormState>();
  void logout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                  key: formkey,
                  child: TextFormField(
                    controller: controllerLogout,
                    decoration: InputDecoration(
                      hintText: 'Masukan Password untuk logout',
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Kolom harus di isi";
                      }
                      if (value != 'PASSWORD') {
                        return "Kolom yang dimasukan salah";
                      }
                      return null;
                    },
                  )),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tidak')),
            TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    if (controllerLogout.text == 'PASSWORD') {
                      BlocProvider.of<LoginCubit>(context).keluar(context);
                      BlocProvider.of<ProsesTransaksiCubit>(context).clearData();
                    }
                  }
                },
                child: Text('Iya')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginCubit>(context).getShopName();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0XFFFF884B),
        title: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is AuthStatus == false) {
              return Text("");
            }
            var userName = (state as AuthStatus).message;
            if (userName!.isEmpty) {
              return Text("");
            }
            return Text(
              userName == "Koperasi" ? "Koperasi" : "Kantin",
              style: GoogleFonts.lato(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(
              FontAwesomeIcons.circleXmark,
              color: Colors.white,
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CHANGE_PASS_OUTLET);
            },
            icon: Icon(
              FontAwesomeIcons.key,
              color: Colors.white,
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, PERIODE);
            },
            icon: Icon(
              FontAwesomeIcons.calendar,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DigitalClock(
                    is24HourTimeFormat: true,
                    areaDecoration: const BoxDecoration(color: Colors.transparent),
                    hourMinuteDigitTextStyle: const TextStyle(color: Colors.black, fontSize: 50),
                    hourMinuteDigitDecoration: const BoxDecoration(color: Colors.transparent),
                    secondDigitDecoration: const BoxDecoration(color: Colors.transparent),
                    secondDigitTextStyle: const TextStyle(color: Colors.black, fontSize: 50),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: controllerBarcode,
                    autofocus: true,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) async {
                      if (value.length >= 9) {
                        // BlocProvider.of<ProsesTransaksiCubit>(context).compareTanggal(controllerBarcode.text);
                        BlocProvider.of<ProsesTransaksiCubit>(context).tukarKoin(controllerBarcode.text);
                        await Future.delayed(Duration(milliseconds: 500));
                        controllerBarcode.clear();
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
                    var status = (state as ProsesTransaksiLoaded).status;
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
                      status,
                      data['t4_penukaran'],
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

  Widget ticket(nama, koin_makan, masa_berlaku, masa_berlaku_akhir, tanggal_penukaran, status_berlaku, barcode, shift, status, tempat_penukaran) {
    return TicketWidget(
      width: 450,
      height: 550,
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
              border: Border.all(
                width: 1.5,
                color: status == 1 ? Colors.green : Colors.black,
              ),
            ),
            child: Center(
              child: Text(
                status_berlaku,
                style: TextStyle(color: status == 1 ? Colors.green : Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
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
                      AutoSizeText(
                        nama,
                        maxLines: 2,
                        minFontSize: 14,
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
                    const SizedBox(height: 6),
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
                const SizedBox(height: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tempat Penukaran",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tempat_penukaran == null
                          ? '-'
                          : tempat_penukaran == "1"
                              ? "Koperasi"
                              : "Kantin",
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
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
                style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
