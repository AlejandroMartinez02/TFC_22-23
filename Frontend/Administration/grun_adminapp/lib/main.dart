import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grun_adminapp/utils/utils.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'login/ui/login_form_provider.dart';
import 'splash/ui/splash_provider.dart';
import 'splash/ui/splash_screen.dart';
import 'utils/services/navigator_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grün',
        initialRoute: 'splash',
        navigatorKey: NavigatorService.navigatorKey,
        scaffoldMessengerKey: NotificationService.messengerKey,
        routes: {'splash': (_) => const SplashScreen()},
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.grey[800],
            textTheme: const TextTheme(
                headlineLarge: TextStyle(
                    fontFamily: 'Paralucent', fontWeight: FontWeight.w700),
                bodyLarge: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ))));
  }
}

//const Color.fromARGB(255, 43, 181, 114)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
