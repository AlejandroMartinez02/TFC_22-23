import 'package:flutter/material.dart';
import 'package:grun_mobileapp/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grün',
        initialRoute: 'login',
        routes: {
          'login': (_) => const LoginScreen(),
          'home': (_) => const HomeScreen()
        },
        theme: ThemeData.light()
            .copyWith(primaryColor: const Color.fromARGB(255, 43, 181, 114)));
  }
}
