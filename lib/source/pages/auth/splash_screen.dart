import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/data/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginCubit>(context).splashScreen(context);
    return const Center(
      child: CircularProgressIndicator(color: Color(0XFFFF884B)),
    );
  }
}
