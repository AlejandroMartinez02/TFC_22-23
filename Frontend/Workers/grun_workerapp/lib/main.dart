import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'login/ui/login_screen.dart';
import 'login/ui/login_form_provider.dart';
import 'utils/services/notification_service.dart';

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
      providers: [ChangeNotifierProvider(create: (_) => LoginFormProvider())],
      child: const WorkerApp(),
    );
  }
}

class WorkerApp extends StatelessWidget {
  const WorkerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grün',
        initialRoute: 'login',
        scaffoldMessengerKey: NotificationService.messengerKey,
        routes: {'login': (_) => LoginScreen()},
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
