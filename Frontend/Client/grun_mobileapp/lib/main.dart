import 'package:flutter/material.dart';
import 'package:grun_mobileapp/screens/screens.dart';
import 'package:grun_mobileapp/services/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductService(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterFormProvider(),
        ),
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
        scaffoldMessengerKey: NotificationService.messengerKey,
        routes: {'splash': (_) => const SplashScreen()},
        theme: ThemeData.light().copyWith(
          primaryColor: const Color.fromARGB(255, 43, 181, 114),
        ));
  }
}
