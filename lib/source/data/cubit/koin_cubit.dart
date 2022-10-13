import 'package:bloc/bloc.dart';
import 'package:flutter_absen_koin/source/data/repository/repository.dart';
import 'package:meta/meta.dart';

part 'koin_state.dart';

class KoinCubit extends Cubit<KoinState> {
  final MyRepository? myRepository;
  KoinCubit({this.myRepository}) : super(KoinInitial());
}
