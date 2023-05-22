import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'exports/providers.dart';
import 'splash/ui/splash_screen.dart';
import 'utils/services/navigator_service.dart';
import 'utils/utils.dart';

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
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DishProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider())
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
    if (Platform.isAndroid || Platform.isIOS) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
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
