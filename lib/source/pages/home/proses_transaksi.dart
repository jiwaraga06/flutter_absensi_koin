import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

class Proses extends StatefulWidget {
  final nama, koin_makan, masa_berlaku, tanggal_penukaran, status_berlaku, barcode;

  const Proses(
      {super.key,
      required this.nama,
      required this.koin_makan,
      required this.masa_berlaku,
      required this.tanggal_penukaran,
      required this.status_berlaku,
      required this.barcode});

  @override
  State<Proses> createState() => _ProsesState();
}

class _ProsesState extends State<Proses> {
  @override
  Widget build(BuildContext context) {
    return TicketWidget(
      width: 450,
      height: 400,
      padding: const EdgeInsets.all(18),
      isCornerRounded: false,
      color: Color(0XFFF5EFE6),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(width: 1.5, color: Colors.green),
            ),
            child: const Center(
              child: Text(
                'Koin Berlaku',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Nama",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          "Raga Puteraku Dermawan",
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Barcode",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          "202009016",
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
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
                    Text(
                      "1",
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
                    Text(
                      "2022-09-29 15:56:30",
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
                      "Tanggal Penukaran",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      "2022-09-29 15:56:30",
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
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
