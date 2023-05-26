import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grun_workerapp/splash/ui/splash_screen.dart';
import 'package:grun_workerapp/utils/constants.dart';
import 'package:grun_workerapp/utils/services/navigator_service.dart';
import 'package:provider/provider.dart';

import 'exports/providers.dart';
import 'utils/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    doWhenWindowReady(() {
      appWindow.title = Constants.appName;
      appWindow.size = const Size(1070, 800);
      appWindow.minSize = const Size(1070, 800);
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => SocketService())
      ],
      child: const WorkerApp(),
    );
  }
}

class WorkerApp extends StatelessWidget {
  const WorkerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < 700) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grün Trabajadores',
        initialRoute: 'splash',
        scaffoldMessengerKey: NotificationService.messengerKey,
        navigatorKey: NavigatorService.navigatorKey,
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
