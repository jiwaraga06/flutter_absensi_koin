part of 'proses_transaksi_cubit.dart';

@immutable
abstract class ProsesTransaksiState {}

class ProsesTransaksiInitial extends ProsesTransaksiState {}

class ProsesTransaksiLoading extends ProsesTransaksiState {}

class ProsesTransaksiLoaded extends ProsesTransaksiState {
  final dynamic result;
  final String? statusKoin;
  final String? tgl_penukaran;

  ProsesTransaksiLoaded({this.result, this.statusKoin, this.tgl_penukaran});
}

class ProsesTransaksiMessage extends ProsesTransaksiState {
  final String? message;

  ProsesTransaksiMessage({this.message});
}

