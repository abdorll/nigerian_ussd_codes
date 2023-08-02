// import 'package:admob_flutter/admob_flutter.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_mobile_ads_manager/google_mobile_ads_manager.dart'; 
import 'package:ussd_bank_codes/routes/app_route.dart';
import 'package:ussd_bank_codes/views/home_screen/home_screen.dart'; 
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.green,
  ));
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nigeria Network',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff17517e)),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return botToastBuilder(context, child);
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: HomeScreen.homeScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
