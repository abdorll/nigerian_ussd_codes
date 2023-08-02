import 'package:flutter/material.dart';
import 'package:ussd_bank_codes/views/banks_screen/banks_screen.dart';
import 'package:ussd_bank_codes/views/home_screen/home_screen.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case BanksOptionListScreen.banksOptionListScreen:
        return MaterialPageRoute(
            builder: (context) => const BanksOptionListScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
