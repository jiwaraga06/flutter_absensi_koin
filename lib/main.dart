import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/data/api/network.dart';
import 'package:flutter_absen_koin/source/data/cubit/koin_cubit.dart';
import 'package:flutter_absen_koin/source/data/cubit/login_cubit.dart';
import 'package:flutter_absen_koin/source/data/cubit/proses_transaksi_cubit.dart';
import 'package:flutter_absen_koin/source/data/repository/repository.dart';
import 'package:flutter_absen_koin/source/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp( MyApp(
    router: RouterNavigation(),
    myRepository: MyRepository(myNetwork: MyNetwork()),
  ));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  final MyRepository? myRepository;
  const MyApp({super.key, this.router, this.myRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (loginCubit) => LoginCubit(myRepository: myRepository),
        ),
        BlocProvider<KoinCubit>(
          create: (loginCubit) => KoinCubit(myRepository: myRepository),
        ),
        BlocProvider<ProsesTransaksiCubit>(
          create: (loginCubit) => ProsesTransaksiCubit(myRepository: myRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router!.generateRoute,
      ),
    );
  }
}
