import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/pages/auth/login.dart';
import 'package:flutter_absen_koin/source/pages/auth/splash_screen.dart';
import 'package:flutter_absen_koin/source/pages/home/proses_transaksi.dart';
import 'package:flutter_absen_koin/source/pages/home/transaksi.dart';
import 'package:flutter_absen_koin/source/router/string.dart';

class RouterNavigation {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_SCREEN:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => const Login());
      case TRANSAKSI:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Transaksi(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      // case PROSES_TRANSAKSI:
      //   return MaterialPageRoute(builder: (context) => const Proses());
      default:
        return null;
    }
  }
}